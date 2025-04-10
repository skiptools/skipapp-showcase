// Copyright 2023–2025 Skip
import SwiftUI

struct BlurPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Radius")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .blur(radius: 10)
                        .border(.blue)
                }
                HStack {
                    Text(".clipShape")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                        .blur(radius: 4)
                        .border(.blue)
                }
                HStack {
                    Text("Shape")
                    Spacer()
                    Circle()
                        .fill(.red)
                        .frame(width: 100, height: 100)
                        .blur(radius: 4)
                        .border(.blue)
                }
                HStack {
                    Text("Text")
                    Spacer()
                    Text("Text").font(.largeTitle).bold()
                        .foregroundStyle(.red)
                        .blur(radius: 4)
                        .border(.blue)
                }
                HStack {
                    Text("Shape with background")
                    Spacer()
                    Circle()
                        .fill(.red)
                        .frame(width: 100, height: 100)
                        .blur(radius: 4)
                        .background {
                            Color.green
                        }
                        .border(.blue)
                }
                HStack {
                    Text("Text with background")
                    Spacer()
                    Text("Text").font(.largeTitle).bold()
                        .foregroundStyle(.red)
                        .padding(8)
                        .blur(radius: 4)
                        .background {
                            Color.green
                        }
                        .border(.blue)
                }
                HStack {
                    Text("Shape with overlay")
                    Spacer()
                    Circle()
                        .fill(.red)
                        .frame(width: 100, height: 100)
                        .overlay {
                            Text("Overlay").font(.largeTitle)
                                .foregroundStyle(.green)
                                .blur(radius: 4)
                        }
                        .border(.blue)
                }
                HStack {
                    Text("Container")
                    Spacer()
                    VStack {
                        Text("Top")
                        Text("Bottom")
                    }
                    .padding(8)
                    .blur(radius: 4)
                    .border(.blue)
                }
                HStack {
                    Text("Button")
                    Spacer()
                    Button("Tap") {
                        logger.log("Tap")
                    }
                    .buttonStyle(.bordered)
                    .blur(radius: 4)
                    .border(.blue)
                }
                Toggle("Toggle", isOn: .constant(true))
                    .blur(radius: 4)
                    .border(.blue)
                HStack {
                    Text("Label")
                    Spacer()
                    Label("Title", systemImage: "heart.fill")
                        .foregroundStyle(.red)
                        .blur(radius: 4)
                        .border(.blue)
                }
                HStack {
                    Text("Image")
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .blur(radius: 4)
                        .border(.blue)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "BlurPlayground.swift")
        }
    }
}
