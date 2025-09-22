// Copyright 2023–2025 Skip
import SwiftUI

struct TimerPlayground: View {
    @State var count = 0

    var body: some View {
        VStack(spacing: 16) {
            TimerPlaygroundTimerView(message: "Tap count: \(count)")
            Button("Tap to recompose in 1 sec") {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    timerDate = Date()
                    ticks += 1
                } catch {
                }
            }
        }
    }
}
