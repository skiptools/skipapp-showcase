// Copyright 2023–2025 Skip
import SwiftUI

struct SpacerPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Before")
                    Spacer()
                    Text("After")
                }
                HStack {
                    Text("Before fixed")
                    Spacer()
                        .frame(width: 100)
                    Text("After fixed")
                }
                VStack {
                    Text("Before vstack")
                    Spacer()
                        .frame(height: 100)
                    Text("After vstack")
                }
                HStack {
                    Text("Before minLength")
                    Spacer(minLength: 32)
                    Text("After minLength")
                }
                .frame(width: 200)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "SpacerPlayground.swift")
        }
    }
}

