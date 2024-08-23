// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct FormPlayground: View {
    @State var stringValue = ""
    @State var boolValue = false
    @State var dateValue = Date.now
    @State var pickerValue = "Two"
    let pickerValues = ["One", "Two", "Three"]

    var body: some View {
        List {
            Label("Label", systemImage: "star.fill")
            Label("Label .font(.title)", systemImage: "star.fill")
                .font(.title)
            Label("Label .foregroundStyle(.red)", systemImage: "star.fill")
                .foregroundStyle(.red)
            Label("Label .tint(.red)", systemImage: "star.fill")
                .tint(.red)
            Label("Label .listItemTint(.red)", systemImage: "star.fill")
                .listItemTint(.red)
            NavigationLink(value: "Test") {
                Label("Label in NavigationLink", systemImage: "star.fill")
            }
            Button("Button .automatic", action: { logger.info("Tap") })
            Button("Button .bordered", action: { logger.info("Tap") })
                .buttonStyle(.bordered)
            Button(action: { logger.info("Tap") }) {
                HStack {
                    Text("Complex content button")
                    Spacer()
                    Button("Inner button", action: { logger.info("Tap inner") })
                }
            }
            ButtonRow()
            DatePicker("DatePicker", selection: $dateValue)
            DatePicker("DatePicker .disabled", selection: $dateValue)
                .disabled(true)
            Picker("Picker", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            Picker("Picker .segmented", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            #if os(macOS)
            #else
            Picker("Picker .navigationLink", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.navigationLink)
            #endif
            Picker("Picker .disabled", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .disabled(true)
            Text("Picker .labelsHidden (below)")
            Picker("Label", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .labelsHidden()
            Picker("Picker .foregroundStyle(.red)", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .foregroundStyle(.red)
            Picker("Picker .tint(.red)", selection: $pickerValue) {
                ForEach(pickerValues, id: \.self) {
                    Text($0)
                }
            }
            .tint(.red)
            Toggle(isOn: $boolValue) {
                Text("Toggle")
            }
            Toggle(isOn: $boolValue) {
                Text("Toggle with label text that is too long to fit on a single line and should be wrapped").lineLimit(100)
            }
            TextField("Text field", text: $stringValue)
        }
        .toolbar {
            PlaygroundSourceLink(file: "ListControlsPlayground.swift")
        }
        .navigationDestination(for: String.self) { value in
            Text(value)
        }
        .onAppear() {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear() {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    struct ButtonRow: View {
        var body: some View {
            Button("Button in custom view") {
                logger.info("Tap")
            }
        }
    }
}
