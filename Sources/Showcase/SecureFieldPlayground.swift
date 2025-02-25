// Copyright 2023–2025 Skip
import SwiftUI

struct SecureFieldPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SecureField("Default", text: $text)
                SecureField("With prompt", text: $text, prompt: Text("Prompt"))
                SecureField("Fixed width", text: $text)
                    .frame(width: 200)
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
        .toolbar {
            PlaygroundSourceLink(file: "SecureFieldPlayground.swift")
        }
    }
}
