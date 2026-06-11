// Copyright 2023–2026 Skip
import SwiftUI

struct AccessibilityPlayground: View {
    @State var isOn = false
    @Environment(\.accessibilityEnabled) var accessibilityEnabled: Bool
    @Environment(\.accessibilityInvertColors) var accessibilityInvertColors: Bool
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion: Bool
    @Environment(\.accessibilityReduceTransparency) var accessibilityReduceTransparency: Bool
    @Environment(\.accessibilitySwitchControlEnabled) var accessibilitySwitchControlEnabled: Bool
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled: Bool
    @Environment(\.legibilityWeight) var legibilityWeight: LegibilityWeight?
    @Environment(\.colorSchemeContrast) var colorSchemeContrast: ColorSchemeContrast

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Simulate a custom control with an accessibility label, value, and traits:")
                Text(isOn ? "+" : "-").font(.largeTitle)
                    .accessibilityLabel("My custom control")
                    .accessibilityValue(isOn ? "On" : "Off")
                    .accessibilityAddTraits(.isButton) // Use .isToggle on iOS 17+
                    .onTapGesture { isOn = !isOn }

                Divider()
                
                Text("Hide the following element from accessibility:")
                Text("Hidden").font(.largeTitle)
                    .accessibilityHeading(.h2)
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
