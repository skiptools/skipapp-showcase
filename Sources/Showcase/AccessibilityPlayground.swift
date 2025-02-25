// Copyright 2023–2025 Skip
import SwiftUI

struct AccessibilityPlayground: View {
    @State var isOn = false

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
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "AccessibilityPlayground.swift")
        }
    }
}
