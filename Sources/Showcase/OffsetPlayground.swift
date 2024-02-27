// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct OffsetPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text(".offset(0, 0)")
                    Spacer()
                    ZStack {
                        Color.clear
                            .frame(width: 100, height: 100)
                            .border(.primary)
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(x: 0, y: 0)
                    }
                }
                HStack {
                    Text(".offset(50, -50)")
                    Spacer()
                    ZStack {
                        Color.clear
                            .frame(width: 100, height: 100)
                            .border(.primary)
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(x: 50, y: -50)
                    }
                }
                HStack {
                    Text(".offset(-50, 50)")
                    Spacer()
                    ZStack {
                        Color.clear
                            .frame(width: 100, height: 100)
                            .border(.primary)
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(x: -50, y: 50)
                    }
                }
                HStack {
                    Text(".offset(CGSize(50, 50))")
                    Spacer()
                    ZStack {
                        Color.clear
                            .frame(width: 100, height: 100)
                            .border(.primary)
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(CGSize(width: 50, height: 50))
                    }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "OffsetPlayground.swift")
        }
    }
}

