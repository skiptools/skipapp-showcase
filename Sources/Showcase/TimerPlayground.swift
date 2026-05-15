// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_FUSE_MODE
struct TimerPlayground: View {
    @State var count = 0

    var body: some View {
        VStack(spacing: 16) {
            TimerPlaygroundTimerView(message: "Tap count: \(count)")
            Button("Tap to recompose in 1 sec") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    count += 1
                }
            }
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "TimerPlayground.swift")
        }
    }
}

struct TimerPlaygroundTimerView: View, @unchecked Sendable {
    let message: String
    @State var timer: Timer?
    @State var timerDate: Date?
    @State var ticks = 0

    var body: some View {
        VStack {
            Text(message)
            Text("Time: \(timerDate == nil ? "nil" : timerDate!.formatted(date: .omitted, time: .standard))")
            Text("Ticks: \(ticks)")
        }
        .font(.largeTitle)
        .task {
            while !Task.isCancelled {
                do {
                    try await Task.sleep(for: .seconds(1))
                    timerDate = Date()
                    ticks += 1
                } catch {
                }
            }
        }
    }
}
#else
struct TimerPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("TimerPlayground uses Combine-style timer publishers not yet bridged for Lite.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "TimerPlayground.swift")
        }
    }
}
#endif
