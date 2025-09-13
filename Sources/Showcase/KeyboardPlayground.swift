// Copyright 2023–2025 Skip
import SwiftUI

struct KeyboardPlayground: View {
    @State var text = ""

    var body: some View {
        List {
            TextField("Default", text: $text)
            TextField(".autocorrectionDisabled", text: $text)
                .autocorrectionDisabled()
            #if os(macOS)
            #else
            NavigationLink(".keyboardType") {
                KeyboardTypePlayground()
                    .navigationTitle(".keyboardType")
            }
            NavigationLink(".scrollDismissesKeyboard") {
                KeyboardScrollDismissPlayground()
                    .navigationTitle(".scrollDismissesKeyboard")
            }
            #endif
            NavigationLink(".submitLabel") {
                KeyboardSubmitLabelPlayground()
                    .navigationTitle(".submitLabel")
            }
            #if os(macOS)
            #else
            NavigationLink(".textInputAutocapitalization") {
                KeyboardAutocapitalizationPlayground()
                    .navigationTitle(".textInputAutocapitalization")
            }
            #endif
        }
        .toolbar {
            PlaygroundSourceLink(file: "KeyboardPlayground.swift")
        }
    }
}

#if os(macOS)
#else
struct KeyboardTypePlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Default", text: $text)
                ForEach(keyboardTypes, id: \.0) {
                    TextField(".keyboardType(.\($0.0))", text: $text)
                        .keyboardType($0.1)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }

    private var keyboardTypes: [(String, UIKeyboardType)] {
        return [
            ("default", UIKeyboardType.default),
            ("asciiCapable", UIKeyboardType.asciiCapable),
            ("numbersAndPunctuation", UIKeyboardType.numbersAndPunctuation),
            ("URL", UIKeyboardType.URL),
            ("numberPad", UIKeyboardType.numberPad),
            ("phonePad", UIKeyboardType.phonePad),
            ("namePhonePad", UIKeyboardType.namePhonePad),
            ("emailAddress", UIKeyboardType.emailAddress),
            ("decimalPad", UIKeyboardType.decimalPad),
            ("twitter", UIKeyboardType.twitter),
            ("webSearch", UIKeyboardType.webSearch),
            ("asciiCapableNumberPad", UIKeyboardType.asciiCapableNumberPad),
            ("alphabet", UIKeyboardType.alphabet)
        ]
    }
}
#endif

#if os(macOS)
#else
struct KeyboardScrollDismissPlayground: View {
    @State var text = ""

    var body: some View {
        List {
            ForEach(scrollDismissesKeyboardModes, id: \.0) { mode in
                NavigationLink("ScrollView.\(mode.0)") {
                    ScrollView {
                        VStack {
                            TextField("Text", text: $text)
                                .padding()
                            ForEach(0..<50) { i in
                                Text("Row \(i)")
                                    .padding()
                            }
                        }
                    }
                    .scrollDismissesKeyboard(mode.1)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                }
                NavigationLink("List.\(mode.0)") {
                    List {
                        TextField("Text", text: $text)
                        ForEach(0..<50) { i in
                            Text("Row \(i)")
                        }
                    }
                    .scrollDismissesKeyboard(mode.1)
                    .textFieldStyle(.roundedBorder)
                }
                NavigationLink("LazyVStack.\(mode.0)") {
                    ScrollView {
                        LazyVStack {
                            TextField("Text", text: $text)
                                .padding()
                            ForEach(0..<50) { i in
                                Text("Row \(i)")
                                    .padding()
                            }
                        }
                    }
                    .scrollDismissesKeyboard(mode.1)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                }
            }
        }
    }

    private var scrollDismissesKeyboardModes: [(String, ScrollDismissesKeyboardMode)] {
        return [
            ("automatic", ScrollDismissesKeyboardMode.automatic),
            ("never", ScrollDismissesKeyboardMode.never),
            ("immediately", ScrollDismissesKeyboardMode.immediately),
            ("interactively", ScrollDismissesKeyboardMode.interactively),
        ]
    }
}
#endif

struct KeyboardSubmitLabelPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Default", text: $text)
                ForEach(submitLabels, id: \.0) {
                    TextField(".submitLabel(.\($0.0))", text: $text)
                        .submitLabel($0.1)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }

    private var submitLabels: [(String, SubmitLabel)] {
        return [
            ("done", SubmitLabel.done),
            ("go", SubmitLabel.done),
            ("send", SubmitLabel.send),
            ("join", SubmitLabel.join),
            ("route", SubmitLabel.route),
            ("search", SubmitLabel.search),
            ("return", SubmitLabel.return),
            ("next", SubmitLabel.next),
            ("continue", SubmitLabel.continue)
        ]
    }
}

#if os(macOS)
#else
struct KeyboardAutocapitalizationPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                TextField("Default", text: $text)
                ForEach(textInputAutocapitalizations, id: \.0) {
                    TextField(".textInputAutocapitalization(.\($0.0))", text: $text)
                        .textInputAutocapitalization($0.1)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
        }
    }

    private var textInputAutocapitalizations: [(String, TextInputAutocapitalization)] {
        return [
            ("never", TextInputAutocapitalization.never),
            ("words", TextInputAutocapitalization.words),
            ("sentences", TextInputAutocapitalization.sentences),
            ("characters", TextInputAutocapitalization.characters)
        ]
    }
}
#endif
