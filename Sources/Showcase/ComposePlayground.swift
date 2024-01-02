// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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

