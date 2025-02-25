// Copyright 2023–2025 Skip
import SwiftUI

struct ComposePlayground: View {
    var body: some View {
        Group {
            #if SKIP
            ComposeView { context in
                androidx.compose.foundation.layout.Column(modifier: context.modifier) {
                    androidx.compose.material3.Text("Hello from Compose!")
                    androidx.compose.material3.Text("This content is rendered with Compose code using ComposeView")
                }
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

