// Copyright 2023–2025 Skip
import SwiftUI

struct ShareLinkPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Default")
                    Spacer()
                    ShareLink(item: "My text")
                }
                HStack {
                    Text("Default URL")
                    Spacer()
                    ShareLink(item: URL(string: "https://skip.tools")!)
                }
                HStack {
                    Text("Subject & Message")
                    Spacer()
                    ShareLink(item: "My text", subject: Text("My subject"), message: Text("My message"))
                }
                HStack {
                    Text("Subject & Message URL")
                    Spacer()
                    ShareLink(item: URL(string: "https://skip.tools")!, subject: Text("My subject"), message: Text("My message"))
                }
                HStack {
                    Text("Title")
                    Spacer()
                    ShareLink("Title", item: "My text")
                }
                HStack {
                    Text(".buttonStyle(.bordered)")
                    Spacer()
                    ShareLink("Title", item: "My text")
                        .buttonStyle(.bordered)
                }
                HStack {
                    Text("Label")
                    Spacer()
                    ShareLink(item: "My text") {
                        Label("Title", systemImage: "heart.fill")
                    }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ShareLinkPlayground.swift")
        }
    }
}
