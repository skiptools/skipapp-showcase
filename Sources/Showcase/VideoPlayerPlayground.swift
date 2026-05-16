// Copyright 2023–2026 Skip
import SwiftUI
#if canImport(SkipAV)
import SkipAV
#else
import AVKit
#endif

struct VideoPlayerPlayground: View {
    var body: some View {
        List(VideoPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(value: type) { Text(type.title) }
        }
        .toolbar {
            PlaygroundSourceLink(file: "VideoPlayerPlayground.swift")
        }
        .navigationDestination(for: VideoPlaygroundType.self) {
            switch $0 {
            case .skipIntro:
                PlayerView(url: URL(string: "https://skip.tools/assets/introduction.mov")!)
                    .navigationTitle(Text($0.title))
            case .loopingClip:
                LoopingPlayerView(url: URL(string: "https://assets.skip.dev/videos/looping_showcase_clip.mp4")!)
                    .navigationTitle(Text($0.title))
            case .bipBop:
                PlayerView(url: URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")!)
                    .navigationTitle(Text($0.title))
            }
        }
    }
}

enum VideoPlaygroundType: String, CaseIterable {
    case skipIntro
    case loopingClip
    case bipBop

    var title: LocalizedStringResource {
        switch self {
        case .skipIntro:
            return LocalizedStringResource("Skip Intro")
        case .loopingClip:
            return LocalizedStringResource("Looping Clip")
        case .bipBop:
            return LocalizedStringResource("BipBop")
        }
    }

    static var allCases: [VideoPlaygroundType] {
        return [
            .skipIntro,
            .loopingClip,
            .bipBop,
        ]
    }
}

struct PlayerView: View {
    @State var player: AVPlayer
    @State var isPlaying: Bool = false

    init(url: URL) {
        self.player = AVPlayer(playerItem: AVPlayerItem(url: url))
    }

    var body: some View {
        VStack {
            Button {
                isPlaying ? player.pause() : player.play()
                isPlaying = !isPlaying
            } label: {
                Image(systemName: isPlaying ? "stop" : "play")
                    .padding()
            }
            VideoPlayer(player: player)
                .onDisappear {
                    player.pause()
                    isPlaying = false
                }
        }
    }
}

struct LoopingPlayerView: View {
    @State var player: AVQueuePlayer
    @State var playerLooper: AVPlayerLooper
    @State var rate = 1.0

    init(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        self.player = queuePlayer
        self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
    }

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                    player.rate = Float(rate)
                }

            Slider(value: $rate, in: 0.0...10.0, label: { Text("Rate") })
                .onChange(of: rate) { newValue in
                    player.rate = Float(newValue)
                }
        }
    }
}
