// Copyright 2023–2025 Skip
import SwiftUI
#if os(macOS)
#elseif canImport(SkipAV)
import SkipAV
#else
import AVFoundation
#endif
#if canImport(SkipFuse) && !SKIP
import SkipFuse
#endif

struct AudioPlayground: View {
    #if !os(iOS) || !SKIP // Skip Lite only
    #else
    @State var isRecording: Bool = false
    @State var errorMessage: String? = nil
    
    @State var audioRecorder: AVAudioRecorder?
    @State var audioPlayer: AVAudioPlayer?

    var captureURL: URL {
        get {
            #if SKIP
            let activity = UIApplication.shared.androidActivity!
            let file = java.io.File(activity.filesDir, "recording.m4a")
            return URL(fileURLWithPath: file.absolutePath)
            #else
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                .first!.appendingPathComponent("recording.m4a")
            #endif
        }
    }
    #endif

    var body: some View {
        #if !os(iOS) || !SKIP // Skip Lite only
        Text("Not supported on macOS or Skip Fuse")
        #else
        return VStack(spacing: 20) {
            Button(action: {
                self.isRecording ? self.stopRecording() : self.startRecording()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(isRecording ? Color.red : Color.green)
                    .cornerRadius(10)
            }
            
            Button(action: {
                try? self.playRecording()
            }) {
                Text("Play Recording")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        #if SKIP
        .onAppear {
            requestAudioRecordingPermission()
        }
        #endif
        #endif
    }
    
    #if !os(iOS) || !SKIP // Skip Lite only
    #else
    func startRecording() {
        do {
            #if !SKIP
            setupAudioSession()
            #endif
            self.audioRecorder = try AVAudioRecorder(url: captureURL, settings: [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue])
        } catch {
            print(error.localizedDescription)
        }
        audioRecorder?.record()
        isRecording = true
    }
    
    func stopRecording() {
        isRecording = false
        audioRecorder?.stop()
    }
    
    func playRecording() throws {
        do {
            guard FileManager.default.fileExists(atPath: captureURL.path) else {
                errorMessage = "Recording file does not exist."
                return
            }
            audioPlayer = try AVAudioPlayer(contentsOf: captureURL)
            
            audioPlayer?.play()
            
            errorMessage = ""
        } catch {
            logger.error("Could not play audio: \(error.localizedDescription)")
            errorMessage = "Could not play audio: \(error.localizedDescription)"
        }
    }
    
    #if SKIP
    func requestAudioRecordingPermission() {
        if let activity = UIApplication.shared.androidActivity {
            let permissions = listOf(android.Manifest.permission.RECORD_AUDIO, android.Manifest.permission.READ_EXTERNAL_STORAGE, android.Manifest.permission.WRITE_EXTERNAL_STORAGE)
            androidx.core.app.ActivityCompat.requestPermissions(activity, permissions.toTypedArray(), 1)
        }
    }
    
    #else
    
    func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
        } catch {
            errorMessage = "Failed to setup audio session: \(error.localizedDescription)"
        }
    }
    #endif
    #endif
}
