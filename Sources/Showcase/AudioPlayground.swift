// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI
import SkipAV

struct AudioPlayground: View {
    @State var isRecording: Bool = false
    @State var errorMessage: String? = nil
    
    var audioRecorder: AVAudioRecorder!
    @State var audioPlayer: AVAudioPlayer?
    
    var captureURL: URL {
        get {
#if SKIP
            let context = ProcessInfo.processInfo.androidContext
            let file = java.io.File(context.filesDir, "recording.m4a")
            return URL(fileURLWithPath: file.absolutePath)
#else
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
                .first!.appendingPathComponent("recording.m4a")
#endif
        }
    }
    
    init() {
        // issue: AVAudioRecorder isn't being set properly?
        self.audioRecorder = try! AVAudioRecorder(url: captureURL, settings: [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue])
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                self.isRecording ? self.stopRecording() : self.startRecording()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .foregroundColor(.white)
            .background(isRecording ? Color.red : Color.green)
            .cornerRadius(10)
            
            Button(action: {
                try! self.playRecording()
            }) {
                Text("Play Recording")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
    
    func startRecording() {
        audioRecorder?.record()
        isRecording = true
    }
    
    func stopRecording() {
        isRecording = false
        audioRecorder?.stop()
    }
    
    func playRecording() throws {
        do {
            audioPlayer?.stop()
            audioPlayer = nil
            
            audioPlayer = try AVAudioPlayer(contentsOf: captureURL)
            
            audioPlayer?.play()
            
            errorMessage = ""
        } catch {
            logger.error("Could not play audio: \(error.localizedDescription)")
            errorMessage = "Could not play audio: \(error.localizedDescription)"
        }
    }
}
