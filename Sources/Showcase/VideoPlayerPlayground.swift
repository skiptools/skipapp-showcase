// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI
import AVKit

/// Demo of a video player
struct VideoPlayerPlayground: View {
    @State var player = AVPlayer(playerItem: AVPlayerItem(url: URL(string: "https://skip.tools/assets/introduction.mov")!))
    @State var isPlaying: Bool = false

    var body: some View {
        VStack {
            Button {
                isPlaying ? player.pause() : player.play()
                //isPlaying.toggle()
                isPlaying = !isPlaying
                player.seek(to: .zero)
            } label: {
                Image(systemName: isPlaying ? "stop" : "play")
                    .padding()
            }

            VideoPlayer(player: player)
                //.frame(width: 320.0, height: 180.0, alignment: .center)
        }
    }
}
