// Copyright 2023–2026 Skip
import SwiftUI

struct MaskPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Circle mask")
                    Spacer()
                    Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .mask {
                            Circle()
                        }
                }
                HStack {
                    Text("RoundedRect mask")
                    Spacer()
                    Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .mask(RoundedRectangle(cornerRadius: 25))
                }
                HStack {
                    Text("Gradient mask")
                    Spacer()
                    Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .mask {
                            LinearGradient(
                                gradient: Gradient(colors: [.black, .clear]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                }
                HStack {
                    Text("Text mask")
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [.red, .orange, .yellow, .green, .blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: 200, height: 80)
                        .mask {
                            Text("SKIP")
                                .font(.system(size: 60, weight: .black))
                        }
                }
                HStack {
                    Text("Star mask")
                    Spacer()
                    Color.blue
                        .frame(width: 150, height: 150)
                        .mask {
                            Image(systemName: "star.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                }
                HStack {
                    Text("VStack mask")
                    Spacer()
                    Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .mask {
                            VStack(spacing: 8) {
                                Circle()
                                Circle()
                            }
                        }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "MaskPlayground.swift")
        }
    }
}
