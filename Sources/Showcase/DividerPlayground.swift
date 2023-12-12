// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct DividerPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                VStack {
                    Text("Default")
                    Divider()
                }
                VStack {
                    Text("Fixed width")
                    Divider()
                        .frame(width: 100.0)
                }
                HStack {
                    Text("Vertical")
                        .padding()
                    Divider()
                }
                .frame(height: 100.0)
                HStack {
                    Text("Vertical fixed height")
                        .padding()
                    Divider()
                        .frame(height: 50.0)
                }
                .frame(height: 100.0)
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
