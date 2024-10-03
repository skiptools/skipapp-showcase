// Copyright 2024 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
