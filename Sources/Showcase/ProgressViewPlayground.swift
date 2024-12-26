// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ProgressViewPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Indeterminate")
                    Spacer()
                    ProgressView()
                }
                HStack {
                    Text("Progress nil")
                    Spacer()
                    ProgressView(value: nil, total: 1)
                }
                HStack {
                    Text("Progress 0.5")
                    Spacer()
                    ProgressView(value: 0.5)
                }
                HStack {
                    Text("Indeterminate linear")
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.linear)
                }
                HStack {
                    Text("Progress 0.5 circular")
                    Spacer()
                    ProgressView(value: 0.5)
                        .progressViewStyle(.circular)
                }
                HStack {
                    Text("Indeterminate, .tint(.red)")
                    Spacer()
                    ProgressView()
                        .tint(.red)
                }
                HStack {
                    Text("Progress 0.5, .tint(.red)")
                    Spacer()
                    ProgressView(value: 0.5)
                        .tint(.red)
                }

                // Labeled

                HStack {
                    ProgressView("Indeterminate")
                    Spacer()
                    ProgressView("Progress nil", value: nil, total: 1)
                }
                HStack {
                    ProgressView("Progress 0.5", value: 0.5)
                    Spacer()
                    ProgressView("Indeterminate linear")
                        .progressViewStyle(.linear)
                }
                HStack {
                    ProgressView("Progress 0.5 circular", value: 0.5)
                        .progressViewStyle(.circular)
                    Spacer()
                    ProgressView {
                        Text("Indeterminate")
                        Text(".tint(.red)")
                    }
                        .tint(.red)
                }
                ProgressView("Progress 0.5, .tint(.red)", value: 0.5)
                    .tint(.red)
                ProgressView(value: 2, total: 3) {
                    Text("2/3")
                    Divider()
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ProgressViewPlayground.swift")
        }
    }
}

#Preview {
    ProgressViewPlayground()
}
