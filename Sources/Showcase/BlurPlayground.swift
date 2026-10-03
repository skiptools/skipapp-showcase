// Copyright 2023–2026 Skip
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
                    Text("Radius with opacity")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .blur(radius: 10)
                        .opacity(0.5)
                        .border(.blue)
                }
                VStack(spacing: 8) {
                    Text("Glow behind a button, on a dark background")
                        .font(.caption)
                    ZStack {
                        Color(red: 0.04, green: 0.06, blue: 0.10)
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [Color(red: 0.49, green: 0.27, blue: 0.83), Color(red: 0.08, green: 0.65, blue: 0.75)], startPoint: .leading, endPoint: .trailing))
                                .blur(radius: 15)
                                .opacity(0.6)
                            Text("Button")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color(red: 0.12, green: 0.16, blue: 0.23))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                                        )
                                )
                                .padding(4)
                        }
                        .frame(height: 60)
                        .padding(.horizontal, 32)
                    }
                    .frame(height: 150)
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
