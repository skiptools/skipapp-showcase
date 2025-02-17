// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI


struct TextFieldPlayground: View {
    @State var text = ""
    @State var phone = ""

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
                TextField("Custom styling", text: $text)
                    .textFieldStyle(.plain)
                    .font(.title.bold().italic())
                    .foregroundStyle(LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom))
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.yellow.gradient)
                    }
                TextField("(###) ###-####", text: $phone)
                    .textFieldStyle(.plain)
                    #if !os(macOS) || os(Android)
                    .keyboardType(UIKeyboardType.phonePad)
                    #endif
                    .onChange(of: phone) { newValue in
                        phone = formatPhone(newValue)
                    }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TextFieldPlayground.swift")
        }
    }

    func formatPhone(_ phoneNumber: String) -> String {
        guard !phoneNumber.isEmpty else {
            return ""
        }

        let digits = String(phoneNumber.filter { $0 >= "0" && $0 <= "9" }.prefix(10))
        var result = digits

        if digits.count > 3 {
            let areaCode = "(\(digits.prefix(3))) "
            result = areaCode + String(digits.dropFirst(3))
        }

        if digits.count > 6 {
            let firstPart = result.prefix(9)
            let secondPart = result.suffix(result.count - 9)
            result = firstPart + "-" + secondPart
        }

        return result
    }
}
