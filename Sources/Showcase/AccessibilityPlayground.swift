// Copyright 2023–2025 Skip
import SwiftUI

struct AccessibilityPlayground: View {
    @State var isOn = false
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @Environment(\.accessibilityInvertColors) var accessibilityInvertColors
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency
    @Environment(\.accessibilitySwitchControlEnabled) var accessibilitySwitchControlEnabled
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.legibilityWeight) var legibilityWeight
    @Environment(\.colorSchemeContrast) var colorSchemeContrast

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Simulate a custom control with an accessibility label, value, and traits:")
                Text(isOn ? "+" : "-").font(.largeTitle)
                    .onTapGesture { isOn = !isOn }
                    .accessibilityLabel("My custom control")
                    .accessibilityValue(isOn ? "On" : "Off")
                    .accessibilityAddTraits(.isButton) // Use .isToggle on iOS 17+
                
                Divider()
                
                Text("Hide the following element from accessibility:")
                Text("Hidden").font(.largeTitle)
                    .accessibilityHidden(true)
                Divider()
                Text(verbatim: "accessibilityEnabled: \(accessibilityEnabled)")
                Text(verbatim: "accessibilityInvertColors: \(accessibilityInvertColors)")
                Text(verbatim: "accessibilityReduceMotion: \(accessibilityReduceMotion)")
                Text(verbatim: "accessibilityReduceTransparency: \(accessibilityReduceTransparency)")
                Text(verbatim: "accessibilitySwitchControlEnabled: \(accessibilitySwitchControlEnabled)")
                Text(verbatim: "accessibilityVoiceOverEnabled: \(accessibilityVoiceOverEnabled)")
                if let legibilityWeight {
                    Text(verbatim: "legibilityWeight: \(String(describing: legibilityWeight))")
                } else {
                    Text(verbatim: "legibilityWeight: nil")
                }
                Text(verbatim: "colorSchemeContrast: \(String(describing: colorSchemeContrast))")

            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "AccessibilityPlayground.swift")
        }
    }
}
