// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct StackPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Before fixed")
                        .border(Color.blue)
                    HStack {
                        Spacer()
                        Text("After expanding")
                    }
                    .border(Color.red)
                    Text("After fixed")
                        .border(Color.blue)
                }
                VStack {
                    Text("Text1")
                    Text("Text2")
                }
                .border(Color.blue)
                Text("Sized to content:")
                VStack(spacing: 0) {
                    Color.red.frame(width: 50, height: 50)
                    Color.green.frame(width: 50, height: 50)
                }
                .border(Color.blue)
                Text("Content sizes to stack:")
                VStack(spacing: 0) {
                    Color.red
                    Color.green
                }
                .frame(width: 50, height: 100)
                .border(Color.blue)
                VStack {
                    Text("Text1")
                    Color.green.frame(width: 50, height: 50)
                }
                .border(Color.blue)
                VStack {
                    Color.red.frame(width: 50, height: 50)
                    Text("Text2")
                }
                .border(Color.blue)
                VStack(content: horizontalStripes)
                    .background(.yellow)
                    .frame(width: 100, height: 100)
                HStack(content: verticalStripes)
                    .background(.yellow)
                    .frame(width: 100, height: 100)
                ZStack {
                    Color.yellow
                    Color.red.padding(25)
                }
                .frame(width: 100, height: 100)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "StackPlayground.swift")
        }
    }

    // Note: these functions are also a test that we can pass functions to SwiftUI content view builders.

    @ViewBuilder private func horizontalStripes() -> some View {
        Spacer()
        Color.red.frame(height: 20)
        Spacer()
        Color.red.frame(height: 20)
        Spacer()
    }

    @ViewBuilder private func verticalStripes() -> some View {
        Spacer()
        Color.red.frame(width: 20)
        Spacer()
        Color.red.frame(width: 20)
        Spacer()
    }
}
