// Copyright 2023–2025 Skip
import SwiftUI

struct PickerPlayground: View {
    let values = ["One", "Two", "Three", "Four", "Five"]
    let longValues = Array(0..<500)
    @State var selectedValue = "Two"
    @State var selectedLongValue = 2

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Note: Picker displays differently when in a Form. See the Form playground")
                    .font(.caption)
                VStack {
                    Text("Viewbuilder init")
                    Picker(selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    } label: {
                        Text("Label")
                    }
                }
                VStack {
                    Text("String init")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                }
                VStack {
                    Text(".pickerStyle(.segmented)")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .pickerStyle(.segmented)
                VStack {
                    Text(".material3SegmentedButton")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .pickerStyle(.segmented)
                #if SKIP
                .material3SegmentedButton {
                    $0.copy(icon: {})
                }
                #elseif os(Android)
                .composeModifier {
                    NoIconModifier()
                }
                #endif
                VStack {
                    Text(".disabled(true)")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .disabled(true)
                    Picker(".pickerStyle(.segmented)", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(true)
                }
                VStack {
                    Text(".foregroundStyle(.red)")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .foregroundStyle(.red)
                    Picker(".pickerStyle(.segmented)", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .foregroundStyle(.red)
                }
                VStack {
                    Text(".tint(.red)")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .tint(.red)
                    Picker(".pickerStyle(.segmented)", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .tint(.red)
                }
                VStack {
                    Text("Label")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Label($0, systemImage: "heart.fill")
                        }
                    }
                    Picker(".pickerStyle(.segmented)", selection: $selectedValue) {
                        ForEach(values, id: \.self) {
                            Label($0, systemImage: "heart.fill")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                VStack {
                    Text("Fixed content")
                    Picker("Label", selection: $selectedValue) {
                        Text(verbatim: values[0]).tag(values[0])
                        Text(verbatim: values[1]).tag(values[1])
                        Text(verbatim: values[2]).tag(values[2])
                        Text(verbatim: values[3]).tag(values[3])
                        Text(verbatim: values[4]).tag(values[4])
                    }
                }
                VStack {
                    Text("Indexed ForEach")
                    Picker("Label", selection: $selectedValue) {
                        ForEach(0..<5) { index in
                            Text(verbatim: values[index]).tag(values[index])
                        }
                    }
                }
                #if os(macOS)
                #else
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
                Picker("Long values", selection: $selectedLongValue) {
                    ForEach(longValues, id: \.self) {
                        // We can only display long values efficiently when we use untagged views
                        Text("Value \($0)")
                    }
                }
                .pickerStyle(.navigationLink)
                #endif
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "PickerPlayground.swift")
        }
    }
}

#if SKIP

struct NoIconModifier : ContentModifier {
    func modify(view: any View) -> any View {
        view.material3SegmentedButton {
            $0.copy(icon: {})
        }
    }
}

#endif
