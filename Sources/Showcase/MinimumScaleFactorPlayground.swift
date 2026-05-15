// Copyright 2023–2026 Skip
import SwiftUI

struct MinimumScaleFactorPlayground: View {
    @State internal var text = "Hello"

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Interactive demo - add letters to see shrinking
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tap + to add letters:")
                    HStack {
                        Button("-") {
                            if text.count > 1 {
                                // Kotlin String has no removeLast(); use dropLast()
                                // which works in both Swift and the transpilation.
                                text = String(text.dropLast())
                            }
                        }
                        .buttonStyle(.bordered)

                        Button("+") {
                            text += "o"
                        }
                        .buttonStyle(.bordered)
                    }

                    Text("Without scaling (wraps):")
                    Text(text)
                        .lineLimit(1)
                        .frame(width: 150, alignment: .leading)
                        .border(Color.gray)

                    Text("With minimumScaleFactor(0.5):")
                    Text(text)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .frame(width: 150, alignment: .leading)
                        .border(Color.gray)
                }

                Divider()

                // Side by side comparison
                VStack(alignment: .leading, spacing: 8) {
                    Text("Side by side (lineLimit 1):")

                    HStack(spacing: 16) {
                        VStack {
                            Text("No scale")
                                .font(.caption)
                            Text("Hello World!")
                                .lineLimit(1)
                                .frame(width: 80)
                                .border(Color.red)
                        }

                        VStack {
                            Text("0.5 scale")
                                .font(.caption)
                            Text("Hello World!")
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .frame(width: 80)
                                .border(Color.green)
                        }
                    }
                }

                Divider()

                // Large title demo
                VStack(alignment: .leading, spacing: 8) {
                    Text("Large title in narrow box:")

                    HStack(spacing: 16) {
                        VStack {
                            Text("No scale")
                                .font(.caption)
                            Text("SKIP")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .frame(width: 60)
                                .border(Color.red)
                        }

                        VStack {
                            Text("0.3 scale")
                                .font(.caption)
                            Text("SKIP")
                                .font(.largeTitle)
                                .minimumScaleFactor(0.3)
                                .lineLimit(1)
                                .frame(width: 60)
                                .border(Color.green)
                        }
                    }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "MinimumScaleFactorPlayground.swift")
        }
    }
}
