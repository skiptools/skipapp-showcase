// Copyright 2023–2025 Skip
import SwiftUI

struct LabeledContentPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                #if !SKIP_MODE_FUSE && !SKIP
                LabeledContent("Label", value: "Value")

                // Not implemented, yet: Text does not support value:, format:. This would make a good improvement.
                // LabeledContent("Label", value: 12, format: IntegerFormatStyle.number)
                #else
                Text("LabeledContent is not yet available in this mode.")
                    .multilineTextAlignment(.center)
                #endif
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabeledContentPlayground.swift")
        }
    }
}

