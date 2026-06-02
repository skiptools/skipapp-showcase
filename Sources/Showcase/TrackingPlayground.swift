// Copyright 2023–2026 Skip
import SwiftUI

struct TrackingPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Default (0)")
                    Spacer()
                    Text("Hello World")
                }
                HStack {
                    Text("Tracking: 2")
                    Spacer()
                    Text("Hello World")
                        .tracking(2)
                }
                HStack {
                    Text("Tracking: 5")
                    Spacer()
                    Text("Hello World")
                        .tracking(5)
                }
                HStack {
                    Text("Tracking: 10")
                    Spacer()
                    Text("Hello World")
                        .tracking(10)
                }
                HStack {
                    Text("Tracking: -1")
                    Spacer()
                    Text("Hello World")
                        .tracking(-1)
                }
                HStack {
                    Text("Large font + tracking")
                    Spacer()
                    Text("SKIP")
                        .font(.largeTitle)
                        .tracking(8)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TrackingPlayground.swift")
        }
    }
}
