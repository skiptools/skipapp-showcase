// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
