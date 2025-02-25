// Copyright 2023–2025 Skip
import SwiftUI

struct DividerPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack {
                    Text("Default")
                    Divider()
                }
                VStack {
                    Text("Fixed width")
                    Divider()
                        .frame(width: 100)
                }
                HStack {
                    Text("Vertical")
                        .padding()
                    Divider()
                }
                .frame(height: 100)
                HStack {
                    Text("Vertical fixed height")
                        .padding()
                    Divider()
                        .frame(height: 50)
                }
                .frame(height: 100)
                VStack {
                    Text(".foregroundStyle(.red)")
                    Divider()
                        .foregroundStyle(.red)
                }
                VStack {
                    Text(".tint(.red)")
                    Divider()
                        .tint(.red)
                }
                Text("Note: colors should not affect Divider appearance")
                    .font(.caption)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "DividerPlayground.swift")
        }
    }
}
