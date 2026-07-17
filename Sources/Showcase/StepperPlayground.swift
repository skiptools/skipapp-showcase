// Copyright 2023–2026 Skip
import SwiftUI

struct StepperPlayground: View {
    @State var intValue = 5
    @State var doubleValue = 2.5
    @State var customValue = 0
    @State var editingStatus = "Not editing"

    var body: some View {
        VStack(spacing: 0) {
            // Fixed header showing current values
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Int: \(intValue)").bold().font(.title2)
                    Text("Double: \(String(format: "%.2f", doubleValue))").bold().font(.title2)
                }
                Spacer()
                Button("Reset") {
                    intValue = 0
                    doubleValue = 0.0
                }
                .buttonStyle(.bordered)
            }
            .padding()

            Divider()

            ScrollView {
                VStack(spacing: 16) {
                    // Basic Int stepper
                    Stepper("Basic Int Stepper", value: $intValue)

                    // Int stepper with step
                    Stepper("Int step: 5", value: $intValue, step: 5)

                    #if !SKIP // stepper ranges only available in Skip Fuse mode
                    // Int stepper with bounds
                    Stepper("Int in 0...10", value: $intValue, in: 0...10)

                    // Int stepper with bounds and step
                    Stepper("Int in 0...20 step 2", value: $intValue, in: 0...20, step: 2)
                    #endif

                    Divider()

                    // Basic Double stepper
                    Stepper("Basic Double Stepper", value: $doubleValue)

                    // Double stepper with step
                    Stepper("Double step: 0.5", value: $doubleValue, step: 0.5)

                    #if !SKIP // stepper ranges only available in Skip Fuse mode
                    // Double stepper with bounds
                    Stepper("Double in 0.0...5.0", value: $doubleValue, in: 0.0...5.0)

                    // Double stepper with bounds and step
                    Stepper("Double in 0.0...10.0 step 0.25", value: $doubleValue, in: 0.0...10.0, step: 0.25)
                    #endif

                    Divider()

                    // Custom increment/decrement
                    VStack {
                        Text("Custom: \(customValue)")
                        Stepper("Custom +10/-5") {
                            customValue += 10
                        } onDecrement: {
                            customValue -= 5
                        }
                    }

                    Divider()

                    // onEditingChanged
                    VStack {
                        Text("Editing status: \(editingStatus)")
                            .foregroundStyle(editingStatus == "Editing..." ? .green : .primary)
                        Stepper("With onEditingChanged", value: $intValue) { editing in
                            editingStatus = editing ? "Editing..." : "Done editing"
                        }
                    }

                    Divider()

                    // ViewBuilder label
                    Stepper {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                            Text("ViewBuilder label")
                        }
                    } onIncrement: {
                        intValue += 1
                    } onDecrement: {
                        intValue -= 1
                    }

                    Divider()

                    // Styling
                    Stepper(".disabled(true)", value: $intValue)
                        .disabled(true)

                    Stepper(".tint(.red)", value: $intValue)
                        .tint(.red)

                    Stepper(".tint(.green)", value: $intValue)
                        .tint(.green)

                    // Labels hidden
                    VStack {
                        Text(".labelsHidden():")
                        Stepper("Hidden label", value: $intValue)
                    }
                    .labelsHidden()
                }
                .padding()
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "StepperPlayground.swift")
        }
    }
}
