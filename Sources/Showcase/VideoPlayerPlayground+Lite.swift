// Copyright 2023–2026 Skip
import SwiftUI

// All SkipAV/AVKit-using helpers live in this file. The file is entirely gated
// behind `#if !SKIP_FUSE_MODE` so the Fuse-mode bridge generator never sees
// these declarations (it sees an effectively empty file). Fuse mode falls back
// to the stub `body` defined in VideoPlayerPlayground.swift.
#if !SKIP_FUSE_MODE

#if canImport(SkipAV)
import SkipAV
#else
import AVKit
#endif

struct VideoPlayerPlaygroundList: View {
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
            case .videoList:
                ScrollingVideoList()
                    .navigationTitle(Text($0.title))
            }
        }
    }
}

enum VideoPlaygroundType: String, CaseIterable {
    case skipIntro
    case loopingClip
    case bipBop
    case videoList

    var title: LocalizedStringResource {
        switch self {
        case .skipIntro:
            return LocalizedStringResource("Skip Intro")
        case .loopingClip:
            return LocalizedStringResource("Looping Clip")
        case .bipBop:
            return LocalizedStringResource("BipBop")
        case .videoList:
            return LocalizedStringResource("Video List")
        }
    }

    static var allCases: [VideoPlaygroundType] {
        return [
            .skipIntro,
            .loopingClip,
            .bipBop,
            //.videoList // needs work
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

struct ScrollingVideoList : View {
    @State var focusedVideo: Video?

    var body: some View {
        List(videoList(100)) { video in
            ScrollingVideoItem(video: video, focusedVideo: $focusedVideo)
            Divider()
                .onAppear {
                    self.focusedVideo = video
                }
        }
        .ignoresSafeArea(edges: .horizontal)
    }
}

struct ScrollingVideoItem : View {
    let video: Video
    @Binding var focusedVideo: Video?

    var body: some View {
        Group {
            if video.id != focusedVideo?.id {
                AsyncImage(url: URL(string: video.thumb)!)
                    .aspectRatio(contentMode: .fit)
            } else {
                let url = URL(string: video.url)!
                let playerItem = AVPlayerItem(url: url)
                let player = AVQueuePlayer(playerItem: playerItem)
                VideoPlayer(player: player)
                    .onAppear {
                        player.play()
                    }
            }
        }
        .frame(height: 200)
        .padding(0)
        .ignoresSafeArea(edges: .horizontal)
    }
}

struct Video : Identifiable {
    var id: UUID = UUID()

    let url: String
    let subtitle: String
    let thumb: String
    let title: String
    let width: Int
    let height: Int
}

/// Repeat the videos `count` times to simulate an infinte scrolling list
func videoList(_ count: Int) -> [Video] {
    var vids = videos
    for _ in 0..<count {
        vids += videos
    }
    return vids
}

let videos = [
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        subtitle: "By Blender Foundation",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
        title: "Big Buck Bunny",
        width: 768,
        height: 432
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        subtitle: "By Blender Foundation",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
        title: "Elephant Dream",
        width: 768,
        height: 432
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
        subtitle: "By Blender Foundation",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg",
        title: "Sintel",
        width: 768,
        height: 327
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
        subtitle: "By Garage419",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/SubaruOutbackOnStreetAndDirt.jpg",
        title: "Subaru Outback On Street And Dirt",
        width: 480,
        height: 270
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
        subtitle: "By Blender Foundation",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg",
        title: "Tears of Steel",
        width: 768,
        height: 320
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
        subtitle: "By Garage419",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/VolkswagenGTIReview.jpg",
        title: "Volkswagen GTI Review",
        width: 480,
        height: 270
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
        subtitle: "By Garage419",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WeAreGoingOnBullrun.jpg",
        title: "We Are Going On Bullrun",
        width: 480,
        height: 270
    ),
    Video(
        url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
        subtitle: "By Garage419",
        thumb: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/WhatCarCanYouGetForAGrand.jpg",
        title: "What care can you get for a grand?",
        width: 480,
        height: 270
    )
]
#endif
