// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct PickerPlayground: View {
    let values = ["One", "Two", "Three", "Four", "Five"]
    @State var selectedValue = "Two"

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text("Viewbuilder init")
                    Spacer()
                    Picker(selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Label")
                    }
                }
                HStack {
                    Text("String init")
                    Spacer()
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                }
                HStack {
                    Text(".disabled(true)")
                    Spacer()
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .disabled(true)
                }
                HStack {
                    Text(".foregroundStyle(.red)")
                    Spacer()
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .foregroundStyle(.red)
                }
                HStack {
                    Text(".tint(.red)")
                    Spacer()
                    Picker(".tint(.red)", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .tint(.red)
                }
                HStack {
                    Text("Label")
                    Spacer()
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Label($0, systemImage: "heart.fill")
                        }
                    }
                }
                HStack {
                    Text("Fixed content")
                    Spacer()
                    Picker("Fixed content", selection: $selectedValue) {
                        Text(verbatim: values[0]).tag(values[0])
                        Text(verbatim: values[1]).tag(values[1])
                        Text(verbatim: values[2]).tag(values[2])
                        Text(verbatim: values[3]).tag(values[3])
                        Text(verbatim: values[4]).tag(values[4])
                    }
                }
                HStack {
                    Text("Indexed ForEach")
                    Spacer()
                    Picker("Indexed ForEach", selection: $selectedValue) {
                        ForEach(0..<5) { index in
                            Text(verbatim: values[index]).tag(values[index])
                        }
                    }
                }
                Picker(".pickerStyle(.navigationLink)", selection: $selectedValue) {
                    ForEach(values, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("Label .navigationLink", selection: $selectedValue) {
                    ForEach(values, id: \.self) {
                        Label($0, systemImage: "heart.fill")
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TogglePlayground.swift")
        }
    }
}
