// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_FUSE_MODE
struct BackgroundPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text(".red")
                    Spacer()
                    ZStack {
                    }
                    .frame(width: 100, height: 100)
                    .background(.red)
                }
                HStack {
                    Text(".red.gradient")
                    Spacer()
                    ZStack {
                    }
                    .frame(width: 100, height: 100)
                    .background(.red.gradient)
                }
                HStack {
                    Text("background()")
                    Spacer()
                    ZStack {
                        Text("Hello")
                            .background()
                    }
                    .frame(width: 100, height: 100)
                    .background(.red)
                }
                HStack {
                    Text(".backgroundStyle(.red)")
                    Spacer()
                    ZStack {
                        Text("Hello")
                            .background()
                    }
                    .frame(width: 100, height: 100)
                    .backgroundStyle(.red)
                }
                HStack {
                    Text(".clipShape(.capsule)")
                    Spacer()
                    Image(systemName: "heart.fill")
                        .frame(width: 100, height: 50)
                        .background(.red.gradient)
                        .clipShape(.capsule)
                }
                HStack {
                    Text("in: Capsule()")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background(.red.opacity(0.2), in: Capsule())
                }
                HStack {
                    Text("Circles")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background {
                            HStack {
                                Circle().fill(.red.opacity(0.2))
                                Circle().fill(.green.opacity(0.2))
                            }
                        }
                        .border(.blue)
                }
                HStack {
                    Text("Large circle")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background {
                            Circle()
                                .fill(.red.opacity(0.2))
                                .frame(width: 100, height: 100)
                        }
                        .border(.blue)
                }
                HStack {
                    Text(".clipped()")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background {
                            HStack {
                                Circle().fill(.red.opacity(0.2))
                                Circle().fill(.red.opacity(0.2))
                            }
                            .frame(width: 200, height: 100)
                        }
                        .clipped()
                        .border(.blue)
                }
                HStack {
                    Text("Small circle")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background {
                            Circle()
                                .fill(.red.opacity(0.2))
                                .frame(width: 20, height: 20)
                        }
                        .border(.blue)
                }
                HStack {
                    Text("alignment: .topLeading")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background(alignment: .topLeading) {
                            Circle()
                                .fill(.red.opacity(0.2))
                                .frame(width: 20, height: 20)
                        }
                        .border(.blue)
                }
                HStack {
                    Text("alignment: .bottomTrailing")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background(alignment: .bottomTrailing) {
                            Circle()
                                .fill(.red.opacity(0.2))
                                .frame(width: 20, height: 20)
                        }
                        .border(.blue)
                }

                // Material backgrounds
                Divider()
                Text("Material Backgrounds").font(.headline)
                Text("Simplified on Android: semi-transparent white overlay")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                ZStack {
                    LinearGradient(colors: [.red, .blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                    VStack(spacing: 8) {
                        Text(".ultraThinMaterial")
                            .padding()
                            .background(.ultraThinMaterial)
                        Text(".thinMaterial")
                            .padding()
                            .background(.thinMaterial)
                        Text(".regularMaterial")
                            .padding()
                            .background(.regularMaterial)
                        Text(".thickMaterial")
                            .padding()
                            .background(.thickMaterial)
                        Text(".ultraThickMaterial")
                            .padding()
                            .background(.ultraThickMaterial)
                    }
                    .padding()
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                HStack {
                    Text("Material in shape")
                    Spacer()
                    Text("Hello")
                        .padding()
                        .background(.regularMaterial, in: Capsule())
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "BackgroundPlayground.swift")
        }
    }
}
#else
struct BackgroundPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("BackgroundPlayground uses material APIs that only SkipFuseUI exposes.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "BackgroundPlayground.swift")
        }
    }
}
#endif
