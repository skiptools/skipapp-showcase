// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SecureFieldPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                SecureField("Default", text: $text)
                SecureField("With prompt", text: $text, prompt: Text("Prompt"))
                SecureField("Fixed width", text: $text)
                    .frame(width: 200.0)
                SecureField(".disabled(true)", text: $text)
                    .disabled(true)
                SecureField(".foregroundStyle(.red)", text: $text)
                    .foregroundStyle(.red)
                SecureField(".tint(.red)", text: $text)
                    .tint(.red)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }
}
