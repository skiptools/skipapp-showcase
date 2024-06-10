// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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

