// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import AVKit
import SwiftUI

enum VideoPlaygroundType: String, CaseIterable {
    case skipIntro
    case loopingClip

    var title: String {
        switch self {
        case .skipIntro:
            return "Skip Intro"
        case .loopingClip:
            return "Looping Clip"
        }
    }
}

struct VideoPlayerPlayground: View {
    var body: some View {
        List(VideoPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "VideoPlayerPlayground.swift")
        }
        .navigationDestination(for: VideoPlaygroundType.self) {
            switch $0 {
            case .skipIntro:
                PlayerView(url: URL(string: "https://skip.tools/assets/introduction.mov")!)
                    .navigationTitle($0.title)
            case .loopingClip:
                LoopingPlayerView(url: URL(string: "https://assets.skip.tools/videos/looping_showcase_clip.mp4")!)
                    .navigationTitle($0.title)
            }
        }
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
    @State private var playerLooper: AVPlayerLooper
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
