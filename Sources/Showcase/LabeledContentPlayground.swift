// Copyright 2023–2025 Skip
import SwiftUI

struct LabeledContentPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LabeledContent("Label", value: "Value")
                
//  Not implemented, yet: Text does not support value:, format:. This would make a good improvement.
//                LabeledContent("Label", value: 12, format: IntegerFormatStyle.number)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabeledContentPlayground.swift")
        }
    }
}

