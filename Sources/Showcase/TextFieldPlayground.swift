// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI


struct TextFieldPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField(text: $text) {
                    Text(".init(text:label:)")
                }
                .textFieldStyle(.roundedBorder)
                TextField(".init(_:text:)", text: $text)
                    .textFieldStyle(.roundedBorder)
                TextField("With prompt", text: $text, prompt: Text("Prompt"))
                    .textFieldStyle(.roundedBorder)
                TextField("Fixed width", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 200)
                TextField(".disabled(true)", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                TextField(".foregroundStyle(.red)", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.red)
                TextField(".tint(.red)", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .tint(.red)
                TextField(".plain", text: $text)
                    .textFieldStyle(.plain)
                TextField(".plain .disabled(true)", text: $text)
                    .textFieldStyle(.plain)
                    .disabled(true)
                TextField(".plain .foregroundStyle(.red)", text: $text)
                    .textFieldStyle(.plain)
                    .foregroundStyle(.red)
                TextField(".plain .tint(.red)", text: $text)
                    .textFieldStyle(.plain)
                    .tint(.red)
                TextField("Custom background", text: $text)
                    .textFieldStyle(.plain)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.yellow)
                    }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TextFieldPlayground.swift")
        }
    }
}
