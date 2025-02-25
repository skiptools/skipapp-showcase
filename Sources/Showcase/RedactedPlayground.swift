// Copyright 2024–2025 Skip
import SwiftUI

struct RedactedPlayground: View {
    var body: some View {
        List {
            Section(".placeholder") {
                NavigationLink("Text") {
                    TextPlayground(redaction: .placeholder)
                }
                NavigationLink("Form") {
                    FormPlayground(redaction: .placeholder)
                }
                NavigationLink("Image") {
                    ImagePlayground(redaction: .placeholder)
                }
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "RedactedPlayground.swift")
        }
    }
}
