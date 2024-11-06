// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct BorderPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text(".border")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .border(.primary)
                }
                HStack {
                    Text(".padding()")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .padding()
                        .border(.primary)
                }
                HStack {
                    Text(".padding([.top, .leading])")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .padding([.top, .leading], 16)
                        .border(.primary)
                }
                HStack {
                    Text("Negative padding")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .padding([.top, .leading], -16)
                        .border(.primary)
                }
                NavigationLink("Infinite frame with padding") {
                    VStack {
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 200)
                        Text("Hello")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal)
                    }
                }
                HStack {
                    Text(".blue, 5")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .border(.blue, width: 5)
                }
                HStack {
                    Text(".blue.gradient, 10")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .border(.blue.gradient, width: 10)
                }
                HStack {
                    Text("VStack")
                    Spacer()
                    VStack {
                        Color.red
                            .frame(width: 100, height: 100)
                            .padding()
                        Color.red
                            .frame(width: 100, height: 100)
                            .padding()
                    }
                    .border(.primary)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "BorderPlayground.swift")
        }
    }
}
