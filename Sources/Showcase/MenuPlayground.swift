// Copyright 2023–2025 Skip
import SwiftUI

struct MenuPlayground: View {
    @State var primaryActionCount = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Menu("Default") {
                    Button("Option 1") { logger.log("Option 1") }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                }
                Menu("PrimaryAction: \(primaryActionCount)") {
                    Button("Option 1") { logger.log("Option 1") }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                } primaryAction: {
                    primaryActionCount += 1
                }
                Menu(".buttonStyle(.bordered)") {
                    Button("Option 1") { logger.log("Option 1") }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                }
                .buttonStyle(.bordered)
                Menu {
                    Button("Option 1") { logger.log("Option 1") }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                } label: {
                    Label("Label", systemImage: "heart.fill")
                }
                Menu("Label items") {
                    Button(action: { logger.log("Option 1") }) { Label("Option 1", systemImage: "heart.fill") }
                    Button(action: { logger.log("Option 2") }) { Label("Option 2", systemImage: "heart.fill") }
                    Button(action: { logger.log("Option 3") }) { Label("Option 3", systemImage: "heart.fill") }
                }
                Menu("Text & Divider") {
                    Text("Text")
                    Button("Option 1") { logger.log("Option 1") }
                    Divider()
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                }
                Menu("Section") {
                    Section("Section") {
                        Button("Option 1") { logger.log("Option 1") }
                    }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                }
                Menu("Nested menu") {
                    Menu("Nested") {
                        Button("Option 1") { logger.log("Option 1") }
                        Button("Option 2") { logger.log("Option 2") }
                        Menu("Nested Again") {
                            Button("Option 3") { logger.log("Option 3") }
                        }
                    }
                    Button("Option 3") { logger.log("Option 3") }
                    Button("Option 4") { logger.log("Option 4") }
                }
            }
            .toolbar {
                Menu("Menu") {
                    Button("Option 1") { logger.log("Option 1") }
                    Button("Option 2") { logger.log("Option 2") }
                    Button("Option 3") { logger.log("Option 3") }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabelPlayground.swift")
        }
    }
}
