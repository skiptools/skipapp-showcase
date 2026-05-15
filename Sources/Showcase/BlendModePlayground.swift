// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_MODE_FUSE
struct BlendModePlayground: View {
    @State internal var selectedMode: BlendMode = .multiply

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Interactive blend mode picker
                Section {
                    VStack(spacing: 16) {
                        Text("Select Blend Mode")
                            .font(.headline)

                        Picker("Blend Mode", selection: $selectedMode) {
                            Text("Normal").tag(BlendMode.normal)
                            Text("Multiply").tag(BlendMode.multiply)
                            Text("Screen").tag(BlendMode.screen)
                            Text("Overlay").tag(BlendMode.overlay)
                            Text("Darken").tag(BlendMode.darken)
                            Text("Lighten").tag(BlendMode.lighten)
                            Text("Color Dodge").tag(BlendMode.colorDodge)
                            Text("Color Burn").tag(BlendMode.colorBurn)
                            Text("Difference").tag(BlendMode.difference)
                            Text("Exclusion").tag(BlendMode.exclusion)
                        }
                        .pickerStyle(.menu)

                        ZStack {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 120, height: 120)
                                .offset(x: -30)

                            Circle()
                                .fill(Color.red)
                                .frame(width: 120, height: 120)
                                .offset(x: 30)
                                .blendMode(selectedMode)
                        }
                        .frame(height: 150)
                        .drawingGroup()
                    }
                }

                Divider()

                // Blend mode examples
                Section {
                    Text("Blend Mode Examples")
                        .font(.headline)

                    blendModeRow(mode: .normal, label: ".normal")
                    blendModeRow(mode: .multiply, label: ".multiply")
                    blendModeRow(mode: .screen, label: ".screen")
                    blendModeRow(mode: .overlay, label: ".overlay")
                    blendModeRow(mode: .darken, label: ".darken")
                    blendModeRow(mode: .lighten, label: ".lighten")
                    blendModeRow(mode: .difference, label: ".difference")
                    blendModeRow(mode: .exclusion, label: ".exclusion")
                }

                Divider()

                // luminanceToAlpha demo
                Section {
                    Text("luminanceToAlpha()")
                        .font(.headline)

                    HStack(spacing: 20) {
                        VStack {
                            Text("Original")
                                .font(.caption)
                            LinearGradient(
                                colors: [.black, .white],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                        }

                        VStack {
                            Text("luminanceToAlpha")
                                .font(.caption)
                            LinearGradient(
                                colors: [.black, .white],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 100, height: 100)
                            .luminanceToAlpha()
                            .background(Color.red)
                        }
                    }
                }

                Divider()

                // drawingGroup demo
                Section {
                    Text("drawingGroup()")
                        .font(.headline)

                    Text("Forces offscreen rendering (flattens view hierarchy)")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    ZStack {
                        ForEach(0..<5) { i in
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .offset(x: CGFloat(i * 15), y: CGFloat(i * 15))
                        }
                    }
                    .drawingGroup()
                    .frame(height: 150)
                }

                Divider()

                // allowsHitTesting demo
                Section {
                    Text("allowsHitTesting()")
                        .font(.headline)

                    AllowsHitTestingDemo()
                }

                Divider()

                // flipsForRightToLeftLayoutDirection demo
                Section {
                    Text("flipsForRightToLeftLayoutDirection()")
                        .font(.headline)

                    FlipsForRTLDemo()
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "BlendModePlayground.swift")
        }
    }

    @ViewBuilder
    private func blendModeRow(mode: BlendMode, label: String) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .frame(width: 100, alignment: .leading)

            Spacer()

            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .offset(x: -15)

                Circle()
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                    .offset(x: 15)
                    .blendMode(mode)
            }
            .frame(width: 100, height: 70)
            .drawingGroup()
        }
    }
}

struct AllowsHitTestingDemo: View {
    @State internal var tapCount = 0
    @State internal var hitTestingEnabled = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Overlay allows hit testing", isOn: $hitTestingEnabled)

            Text("Tap count: \(tapCount)")
                .font(.caption)

            ZStack {
                Button("Tap Me") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)

                Color.red.opacity(0.3)
                    .frame(width: 200, height: 100)
                    .allowsHitTesting(hitTestingEnabled)
            }

            Text(hitTestingEnabled ? "Red overlay blocks taps" : "Taps pass through overlay")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct FlipsForRTLDemo: View {
    @State internal var isRTL = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("RTL Layout", isOn: $isRTL)

            HStack(spacing: 40) {
                VStack {
                    Text("Normal")
                        .font(.caption)
                    Text("→")
                        .font(.system(size: 48))
                }

                VStack {
                    Text("Flips for RTL")
                        .font(.caption)
                    Text("→")
                        .font(.system(size: 48))
                        .flipsForRightToLeftLayoutDirection(true)
                }
            }
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)

            HStack {
                Text("Leading")
                Spacer()
                Text("Trailing")
            }
            .padding(.horizontal)
            .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        }
    }
}
#else
struct BlendModePlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("BlendModePlayground reaches into Compose LayoutDirection enum, which only SkipFuseUI's Compose bridge resolves.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "BlendModePlayground.swift")
        }
    }
}
#endif
