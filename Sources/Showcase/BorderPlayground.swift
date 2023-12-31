// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct BorderPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text(".border")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .border(.primary)
                }
                HStack {
                    Text(".padding()")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .padding()
                        .border(.primary)
                }
                HStack {
                    Text(".padding([.top, .leading])")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .padding([.top, .leading], 32.0)
                        .border(.primary)
                }
                HStack {
                    Text(".blue, 5.0")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .border(.blue, width: 5.0)
                }
                HStack {
                    Text(".blue.gradient, 10.0")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .border(.blue.gradient, width: 10.0)
                }
                HStack {
                    Text("VStack")
                    Spacer()
                    VStack {
                        Color.red
                            .frame(width: 100.0, height: 100.0)
                            .padding()
                        Color.red
                            .frame(width: 100.0, height: 100.0)
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
