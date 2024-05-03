// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct FramePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack {
                    Text("width: 100")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(width: 100)
                        Text("B")
                    }
                }
                .frame(height: 50)
                VStack {
                    Text("height: 50")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(height: 50)
                        Text("B")
                    }
                }
                VStack {
                    Text("width: 100, height: 50")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(width: 100, height: 50)
                        Text("B")
                    }
                }
                VStack {
                    Text("maxWidth: .infinity, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("HStack maxWidth: .infinity")
                    HStack {
                        Text("A")
                        Text("B")
                            .frame(maxWidth: .infinity)
                            .border(.blue)
                        Text("C")
                    }
                }
                VStack {
                    Text("VStack maxWidth: .infinity")
                    VStack {
                        Text("A")
                        Text("B")
                            .frame(maxWidth: .infinity)
                            .border(.blue)
                        Text("C")
                    }
                }
                VStack {
                    Text("VStack minWidth: 20, maxWidth: .infinity")
                    VStack {
                        Text("A")
                        Text("B")
                            .frame(minWidth: 20, maxWidth: .infinity)
                            .border(.blue)
                        Text("C")
                    }
                }
                VStack {
                    Text("maxWidth: .infinity, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Color.blue
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 300, minHeight: 100\n  minHeight: 100, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 300, minHeight: 100, maxHeight: .infinity)
                        Color.blue
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 100, maxHeight: .infinity\n  maxWidth: .infinity, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 100, maxHeight: .infinity)
                        Color.blue
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("width: 100, height: 100")
                    Text("A")
                        .frame(width: 100, height: 100)
                        .border(.primary)
                }
                VStack {
                    Text("alignment: .bottomTrailing")
                    Text("A")
                        .frame(width: 100, height: 100, alignment: .bottomTrailing)
                        .border(.primary)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "FramePlayground.swift")
        }
    }
}
