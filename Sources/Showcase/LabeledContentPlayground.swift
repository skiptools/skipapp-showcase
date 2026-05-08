// Copyright 2023–2025 Skip
import SwiftUI

struct LabeledContentPlayground: View {
    #if os(macOS)
    let placement: ToolbarItemPlacement = .automatic
    #else
    let placement: ToolbarItemPlacement = .topBarLeading
    #endif
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LabeledContent("Label", value: "Value")
//                LabeledContent("Label", value: 12, format: IntegerFormatStyle.number)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabeledContentPlayground.swift")
        }
    }
}

