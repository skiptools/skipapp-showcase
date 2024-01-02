// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct DatePickerPlayground: View {
    @State var selectedDate = Date.now

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
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
