// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct LinkPlayground: View {
    @Environment(\.openURL) var openURL
    let destination = URL(string: "https://skip.tools")!

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Link(destination: destination) {
                    Text(".init(destination:label:)")
                }
                Link(".init(_:destination:)", destination: destination)
                Link(destination: destination) {
                    Image(systemName: "heart.fill")
                }
                .border(.blue)
                Link(".buttonStyle(.bordered)", destination: destination)
                    .buttonStyle(.bordered)
                Link(".foregroundStyle(.red)", destination: destination)
                    .foregroundStyle(.red)
                Link(".tint(.red)", destination: destination)
                    .tint(.red)
                Button("@Environment(\\.openURL)") {
                    openURL(destination)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LinkPlayground.swift")
        }
    }
}
