// Copyright 2023–2026 Skip
import SwiftUI

// VideoPlayerPlayground.swift only contains the *entry point* view so that the
// Fuse-mode bridge generator (which doesn't honor SKIP_FUSE_MODE in the AST)
// doesn't see SkipAV-dependent types. The real implementation, plus all of the
// AVKit/SkipAV helper structs, lives in VideoPlayerPlayground+Lite.swift and
// is gated to Lite mode.

struct VideoPlayerPlayground: View {
    var body: some View {
        #if SKIP_FUSE_MODE
        VStack(spacing: 16) {
            Text("Video playback uses SkipAV, which is not yet bridged for Skip Fuse.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=lite to see the video playgrounds.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "VideoPlayerPlayground.swift")
        }
        #else
        VideoPlayerPlaygroundList()
        #endif
    }
}
