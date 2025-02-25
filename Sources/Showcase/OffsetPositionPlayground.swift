// Copyright 2023–2025 Skip
import SwiftUI

struct OffsetPositionPlayground: View {
    @State var tapCount = 0

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
                HStack {
                    Text("Tap count: \(tapCount)")
                    Spacer()
                    ZStack {
                        Color.clear
                            .frame(width: 100, height: 100)
                            .border(.primary)
                        Color.red
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                tapCount += 1
                            }
                            .offset(CGSize(width: 50, height: 50))
                    }
                }
                HStack {
                    Text(".position(0, 0)")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .position(x: 0, y: 0)
                    }
                    .frame(width: 100, height: 100)
                    .border(.primary)
                }
                HStack {
                    Text(".position(50, 50)")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .position(x: 50, y: 50)
                    }
                    .frame(width: 100, height: 100)
                    .border(.primary)
                }
                HStack {
                    Text(".position(CGPoint(75, 75))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .position(CGPoint(x: 75, y: 75))
                    }
                    .frame(width: 100, height: 100)
                    .border(.primary)
                }
                NavigationLink("Push Text.position(100, 100)") {
                    Text("Over here!")
                        .background(.yellow)
                        .position(x: 100, y: 100)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "OffsetPositionPlayground.swift")
        }
    }
}

