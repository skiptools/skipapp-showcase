// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

@available(macOS 14.0, iOS 17.0, *)
struct HapticFeedbackPlayground: View {
    @State private var feedbackValue = 0.0
    @State private var feedbackType = FeedbackType.success

    enum FeedbackType: String, CaseIterable {
        case success
        case warning
        case error
        case selection
        case increase
        case decrease
        case start
        case stop
        case alignment
        case levelChange
        case impact

        /// Converts this picker enumeraton into the actual SensoryFeedback to use
        var sensoryFeedback: SensoryFeedback {
            switch self {
            case .success: return .success
            case .warning: return .warning
            case .error: return .error
            case .selection: return .selection
            case .increase: return .increase
            case .decrease: return .decrease
            case .start: return .start
            case .stop: return .stop
            case .alignment: return .alignment
            case .levelChange: return .levelChange
            case .impact: return .impact
            }
        }

        var color: Color {
            switch self {
            case .success: return .green
            case .warning: return .yellow
            case .error: return .red
            case .selection: return .cyan
            case .increase: return .mint
            case .decrease: return .purple
            case .start: return .pink
            case .stop: return .brown
            case .alignment: return .yellow
            case .levelChange: return .orange
            case .impact: return .teal
            }
        }
    }
    var body: some View {
        VStack {
            Spacer()
            Picker(selection: $feedbackType) {
                ForEach(FeedbackType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            } label: {
                Text("Feedback Type")
            }

            Divider()

            Button("Haptic Feedback: \(feedbackType.rawValue)") {
                feedbackValue = feedbackValue >= 100 ? 0.0 : (feedbackValue + 1)
            }
            .buttonStyle(.borderedProminent)
            .bold()

            Slider(value: $feedbackValue, in: 0...100)

            Spacer()
        }
        .tint(feedbackType.color)
        .sensoryFeedback(trigger: feedbackValue) { oldValue, newValue in
            feedbackType.sensoryFeedback
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "HapticFeedbackPlayground.swift")
        }
    }
}

