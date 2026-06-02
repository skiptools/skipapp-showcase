// Copyright 2023–2026 Skip
import SwiftUI

struct ComposePlayground: View {
    var body: some View {
        Group {
            #if SKIP
            // In Skip Lite (transpiled), we can include the Compose code directly inline
            ComposeView { context in
                androidx.compose.foundation.layout.Column(modifier: context.modifier) {
                    androidx.compose.material3.Text("Hello from Compose!")
                    androidx.compose.material3.Text("This content is rendered with Compose code using ComposeView")
                }
            }
            .border(.blue)
            #elseif os(Android)
            // In Skip Fuse (compiled), the transpiled MessageComposer in the SKIP block (below) is bridged to the native layer, which we can then include within a ComposeView
            ComposeView {
                MessageComposer(message: Text("Welcome"), textColor: .red)
            }
            .border(.blue)
            #else
            Text("This view only renders on Android")
            #endif
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "ComposePlayground.swift")
        }
    }
}

#if SKIP

struct MessageComposer: ContentComposer {
    let message: Text
    let textColor: Color

    @Composable override func Compose(context: ComposeContext) {
        androidx.compose.foundation.layout.Column(modifier: context.modifier) {
            androidx.compose.material3.Text(message.localizedTextString(), color: textColor.asComposeColor())
            androidx.compose.material3.Text("This content is rendered with Compose code using ComposeView")
        }
    }
}

#endif
