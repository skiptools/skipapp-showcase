// Copyright 2023–2025 Skip
import Foundation
import SwiftUI

struct LinkPlayground: View {
    @Environment(\.openURL) var openURL
    let destination = URL(string: "https://skip.tools")!

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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
                Link("Remapped URL", destination: destination)
                    .environment(\.openURL, OpenURLAction { url in
                        return .systemAction(URL(string: url.absoluteString + "/docs")!)
                    })
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
