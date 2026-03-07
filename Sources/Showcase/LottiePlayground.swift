// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipMotion

/// This component uses the `SkipMotion` module from https://source.skip.tools/skip-motion
struct LottiePlayground: View {
    @State internal var refreshID = UUID()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 1. Basic Playback
                PlaybackSection()

                Divider()

                // 2. Animation Speed
                SpeedSection()

                Divider()

                // 3. Loop Modes
                LoopModeSection()

                Divider()

                // 4. Content Mode
                ContentModeSection()

                Divider()

                // 5. Progress Scrubbing
                ScrubSection()

                Divider()

                // 6. Clip Range
                ClipRangeSection()

                Divider()

                // 7. Enable Merge Paths
                MergePathsSection()

                Divider()

                // 8. On Complete Callback
                OnCompleteSection()

                Divider()

                // 9. Current Frame
                CurrentFrameSection()
            }
            .padding()
            .id(refreshID)
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Shuffle") {
                    refreshID = UUID()
                }
            }
        }
    }
}

// MARK: - Section Components

internal struct PlaybackSection: View {
    @State internal var isPlaying = true
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("1. Play / Pause")
                .font(.headline)

            Text("Control animation playback with isPlaying")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, isPlaying: isPlaying)
                    .frame(width: 120, height: 120)

                Spacer()

                Toggle("Playing", isOn: $isPlaying)
                    .frame(width: 140)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct SpeedSection: View {
    @State internal var speed: Double = 1.0
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("2. Animation Speed")
                .font(.headline)

            Text("Adjust playback speed (0.1x - 3.0x)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, animationSpeed: speed)
                    .frame(width: 120, height: 120)

                Spacer()

                VStack {
                    Text("\(speed, specifier: "%.1f")x")
                        .font(.title2)
                        .font(Font.system(.body, design: .monospaced))
                    Slider(value: $speed, in: 0.1...3.0, step: 0.1)
                        .frame(width: 140)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct LoopModeSection: View {
    @State internal var loopMode: MotionLoopMode = .loop
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("3. Loop Mode")
                .font(.headline)

            Text("Control how animation repeats")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, loopMode: loopMode)
                    // Force view recreation when loopMode changes, otherwise SwiftUI won't re-render
                    // since the view's identity doesn't change when only the loopMode parameter changes
                    .id(loopMode)
                    .frame(width: 120, height: 120)

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(loopModes, id: \.label) { mode in
                        Button {
                            loopMode = mode.value
                        } label: {
                            HStack {
                                Image(systemName: loopMode == mode.value ? "checkmark.circle.fill" : "circle.dashed")
                                Text(mode.label)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }

    private var loopModes: [(label: String, value: MotionLoopMode)] {
        [
            ("Play Once", .playOnce),
            ("Loop", .loop),
            ("Auto Reverse", .autoReverse),
            ("Repeat 3x", .repeat(3))
        ]
    }
}

internal struct ContentModeSection: View {
    @State internal var contentMode: MotionContentMode = .fit
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("4. Content Mode")
                .font(.headline)

            Text("Control how animation scales within bounds")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 12) {
                VStack {
                    Text("Fit")
                        .font(.caption)
                    MotionView(lottie: animation, contentMode: .fit)
                        .frame(width: 70, height: 100)
                        .border(Color.green)
                        .clipped()
                }

                VStack {
                    Text("Fill")
                        .font(.caption)
                    MotionView(lottie: animation, contentMode: .fill)
                        .frame(width: 70, height: 100)
                        .border(Color.orange)
                        .clipped()
                }

                VStack {
                    Text("scaledToFill")
                        .font(.caption2)
                    MotionView(lottie: animation, contentMode: .fit)
                        .scaledToFill()
                        .frame(width: 70, height: 100)
                        .border(Color.red)
                        .clipped()
                }

                Spacer()
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct ScrubSection: View {
    @State internal var progress: Double = 0.5
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("5. Progress Scrubbing")
                .font(.headline)

            Text("Seek to specific position (0.0 - 1.0)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, isPlaying: false, currentProgress: progress)
                    .frame(width: 120, height: 120)

                Spacer()

                VStack {
                    Text("\(Int(progress * 100))%")
                        .font(.title2)
                        .font(Font.system(.body, design: .monospaced))
                    Slider(value: $progress, in: 0.0...1.0, step: 0.01)
                        .frame(width: 140)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct ClipRangeSection: View {
    @State internal var fromProgress: Double = 0.0
    @State internal var toProgress: Double = 0.5
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("6. Clip Range")
                .font(.headline)

            Text("Play only a portion of the animation")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, fromProgress: fromProgress, toProgress: toProgress)
                    .frame(width: 120, height: 120)

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("From:")
                            .frame(width: 45, alignment: .leading)
                        Text("\(Int(fromProgress * 100))%")
                            .font(Font.system(.body, design: .monospaced))
                            .frame(width: 40)
                        Slider(value: $fromProgress, in: 0.0...1.0, step: 0.05)
                            .frame(width: 80)
                    }
                    HStack {
                        Text("To:")
                            .frame(width: 45, alignment: .leading)
                        Text("\(Int(toProgress * 100))%")
                            .font(Font.system(.body, design: .monospaced))
                            .frame(width: 40)
                        Slider(value: $toProgress, in: 0.0...1.0, step: 0.05)
                            .frame(width: 80)
                    }
                    if fromProgress >= toProgress {
                        Text("From must be < To")
                            .font(.caption2)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct MergePathsSection: View {
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("7. Enable Merge Paths")
                .font(.headline)

            Text("For animations using After Effects boolean shape operations")
                .font(.caption)
                .foregroundColor(.secondary)

            MotionView(lottie: animation, enableMergePaths: true)
                .frame(width: 120, height: 120)

            VStack(alignment: .leading, spacing: 4) {
                Text("iOS: Not supported (ignored)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("Android: Disabled by default for performance")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text("Only needed for complex overlapping shapes")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct OnCompleteSection: View {
    @State internal var isPlaying = false
    @State internal var completionCount = 0
    @State internal var lastFinished = true
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("8. On Complete Callback")
                .font(.headline)

            Text("Get notified when animation finishes")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(
                    lottie: animation,
                    loopMode: .playOnce,
                    isPlaying: isPlaying,
                    onComplete: { finished in
                        completionCount += 1
                        lastFinished = finished
                        isPlaying = false
                    }
                )
                .frame(width: 120, height: 120)

                Spacer()

                VStack(alignment: .leading, spacing: 8) {
                    Button(isPlaying ? "Playing..." : "Play Once") {
                        isPlaying = true
                    }
                    .disabled(isPlaying)

                    Text("Completions: \(completionCount)")
                        .font(.subheadline)
                        .font(Font.system(.body, design: .monospaced))

                    if completionCount > 0 {
                        Text("Last: \(lastFinished ? "finished" : "interrupted")")
                            .font(.caption)
                            .foregroundColor(lastFinished ? .green : .orange)
                    }
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

internal struct CurrentFrameSection: View {
    @State internal var currentFrame: Double = 0
    internal var animation = randomAnimation()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("9. Current Frame")
                .font(.headline)

            Text("Seek to specific frame number")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                MotionView(lottie: animation, isPlaying: false, currentFrame: currentFrame)
                    .frame(width: 120, height: 120)

                Spacer()

                VStack(alignment: .leading, spacing: 4) {
                    Text("Frame: \(Int(currentFrame))")
                        .font(.title2)
                        .font(Font.system(.body, design: .monospaced))

                    Text("Range: \(Int(animation.startFrame)) - \(Int(animation.endFrame))")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Slider(value: $currentFrame, in: animation.startFrame...animation.endFrame, step: 1)
                        .frame(width: 140)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Sample Data

internal let allAnimations: [LottieContainer] = (1...22).map { i in
    let name = String(format: "lottie-loader-%02d.json", i)
    return try! LottieContainer(data: Data(contentsOf: Bundle.module.url(forResource: name, withExtension: nil)!))
}

internal func randomAnimation() -> LottieContainer {
    allAnimations.randomElement()!
}
