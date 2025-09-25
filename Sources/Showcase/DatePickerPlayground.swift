// Copyright 2023–2025 Skip
import Foundation
import SwiftUI

struct DatePickerPlayground: View {
    @State var selectedDate = Date.now

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                DatePicker(selection: $selectedDate) {
                    Text("Viewbuilder init")
                }
                DatePicker("String init", selection: $selectedDate)
                VStack {
                    Text(".labelsHidden():")
                    DatePicker("Label", selection: $selectedDate)
                }
                .labelsHidden()
                DatePicker(".buttonStyle(.plain)", selection: $selectedDate)
                    .buttonStyle(.plain)
                DatePicker(".disabled(true)", selection: $selectedDate)
                    .disabled(true)
                DatePicker(".foregroundStyle(.red)", selection: $selectedDate)
                    .foregroundStyle(.red)
                DatePicker(".tint(.red)", selection: $selectedDate)
                    .tint(.red)
                DatePicker("Date only", selection: $selectedDate, displayedComponents: .date)
                DatePicker("Time only", selection: $selectedDate, displayedComponents: .hourAndMinute)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "DatePickerPlayground.swift")
        }
    }
}
