// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct HapticFeedbackPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                #if !os(macOS)
                Button("Impact: Soft") {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                .tint(.cyan)
                Button("Impact: Medium") {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
                .tint(.teal)
                Button("Impact: Heavy") {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                }
                .tint(.indigo)

                Divider()

                Button("Impact Intensity: 20%") {
                    UIImpactFeedbackGenerator().impactOccurred(intensity: 0.2)
                }

                Button("Impact Intensity: 40%") {
                    UIImpactFeedbackGenerator().impactOccurred(intensity: 0.4)
                }

                Button("Impact Intensity: 60%") {
                    UIImpactFeedbackGenerator().impactOccurred(intensity: 0.6)
                }

                Button("Impact Intensity: 80%") {
                    UIImpactFeedbackGenerator().impactOccurred(intensity: 0.8)
                }

                Button("Impact Intensity: 100%") {
                    UIImpactFeedbackGenerator().impactOccurred(intensity: 1.0)
                }

                Divider()

                Button("Selection: Changed") {
                    UISelectionFeedbackGenerator().selectionChanged()
                }

                Divider()

                Button("Notification: Success") {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
                .tint(.green)

                Button("Notification: Warning") {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
                .tint(.yellow)

                Button("Notification: Error") {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
                .tint(.red)
                #endif
            }
            .buttonStyle(.borderedProminent)
            .bold()
        }
        .toolbar {
            PlaygroundSourceLink(file: "HapticFeedbackPlayground.swift")
        }
    }
}

