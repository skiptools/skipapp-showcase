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
            VStack(spacing: 16.0) {
                TextField(text: $text) {
                    Text("Viewbuilder init")
                }
                TextField("String init", text: $text)
                TextField("With prompt", text: $text, prompt: Text("Prompt"))
                TextField("Fixed width", text: $text)
                    .frame(width: 200.0)
                TextField(".disabled(true)", text: $text)
                    .disabled(true)
                TextField(".foregroundStyle(Color.red)", text: $text)
                    .foregroundStyle(Color.red)
                TextField(".tint(.red)", text: $text)
                    .tint(.red)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
}
