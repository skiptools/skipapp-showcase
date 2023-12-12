// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct LabelPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Label {
                    Text(".init(_:icon:)")
                } icon: {
                    Image(systemName: "star.fill")
                }
                Label(".init(_:systemImage:)", systemImage: "star.fill")
                Label(".font(.title)", systemImage: "star.fill")
                    .font(.title)
                Label(".foregroundStyle(.red)", systemImage: "star.fill")
                    .foregroundStyle(.red)
                Label(".tint(.red)", systemImage: "star.fill")
                    .tint(.red)
                Text("Note: tint should not affect Label appearance")
                    .font(.caption)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabelPlayground.swift")
        }
    }
}

