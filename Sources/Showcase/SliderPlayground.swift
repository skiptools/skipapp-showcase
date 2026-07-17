// Copyright 2023–2026 Skip
import SwiftUI

struct SliderPlayground: View {
    @State var value = 0.0
    @State var editingStatus = "Not editing"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Value: \(String(format: "%.2f", value))").bold().font(.title)
                Divider()
                Slider(value: $value)
                HStack {
                    Text("in: 0...2 step 0.5")
                    Slider(value: $value, in: 0...2, step: 0.5)
                }
                HStack {
                    Text("in: 0...1000 step 25")
                    Slider(value: $value, in: 0...1000, step: 25)
                }

                Divider()

                // onEditingChanged examples
                VStack(spacing: 8) {
                    Text("onEditingChanged").font(.headline)
                    Text("Status: \(editingStatus)")
                        .foregroundStyle(editingStatus == "Editing..." ? .green : .primary)
                    Slider(value: $value, in: 0...100) { editing in
                        editingStatus = editing ? "Editing..." : "Done editing"
                    }
                }

                VStack(spacing: 8) {
                    Text("With label (for accessibility)")
                    Text("Labels are not visually displayed").font(.caption).foregroundStyle(.secondary)
                    Slider(value: $value, in: 0...100) {
                        Text("Volume")
                    } onEditingChanged: { editing in
                        editingStatus = editing ? "Editing..." : "Done editing"
                    }
                }

                Divider()

                HStack {
                    Text(".disabled(true)")
                    Slider(value: $value)
                        .disabled(true)
                }
                HStack {
                    Text(".foregroundStyle(.red)")
                    Slider(value: $value)
                        .foregroundStyle(.red)
                }
                HStack {
                    Text(".tint(.red)")
                    Slider(value: $value)
                        .tint(.red)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "SliderPlayground.swift")
        }
    }
}
