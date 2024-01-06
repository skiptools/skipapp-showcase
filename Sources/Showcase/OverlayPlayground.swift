// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct OverlayPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text(".red.opacity(0.5)")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay(.red.opacity(0.5))
                }
                HStack {
                    Text("in: Capsule()")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay(.red.opacity(0.5), in: Capsule())
                }
                HStack {
                    Text("Circles")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay {
                            HStack {
                                Circle().fill(.red.opacity(0.5))
                                Circle().fill(.green.opacity(0.5))
                            }
                        }
                        .border(.blue)
                }
                HStack {
                    Text("Large circle")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay {
                            Circle()
                                .fill(.red.opacity(0.5))
                                .frame(width: 100.0, height: 100.0)
                        }
                        .border(.blue)
                }
                HStack {
                    Text(".clipped()")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay {
                            HStack {
                                Circle().fill(.red.opacity(0.5))
                                Circle().fill(.red.opacity(0.5))
                            }
                            .frame(width: 200.0, height: 100.0)
                        }
                        .clipped()
                        .border(.blue)
                }
                HStack {
                    Text("Small circle")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay {
                            Circle()
                                .fill(.red.opacity(0.5))
                                .frame(width: 20.0, height: 20.0)
                        }
                        .border(.blue)
                }
                HStack {
                    Text("alignment: .topLeading")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay(alignment: .topLeading) {
                            Circle()
                                .fill(.red.opacity(0.5))
                                .frame(width: 20.0, height: 20.0)
                        }
                        .border(.blue)
                }
                HStack {
                    Text("alignment: .bottomTrailing")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .overlay(alignment: .bottomTrailing) {
                            Circle()
                                .fill(.red.opacity(0.5))
                                .frame(width: 20.0, height: 20.0)
                        }
                        .border(.blue)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "OverlayPlayground.swift")
        }
    }
}
