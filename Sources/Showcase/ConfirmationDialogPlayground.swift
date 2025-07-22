// Copyright 2023–2025 Skip
import SwiftUI

struct ConfirmationDialogPlayground: View {
    @State var value = ""
    @State var data: Int? = nil
    @State var defaultIsPresented = false
    @State var titleIsPresented = false
    @State var titleMessageIsPresented = false
    @State var customCancelIsPresented = false
    @State var dataIsPresented = false
    @State var scrollingIsPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Text(value).bold()
            Button("Default") {
                defaultIsPresented = true
            }
            Button("Title") {
                titleIsPresented = true
            }
            Button("Title + Message") {
                titleMessageIsPresented = true
            }
            Button("Custom Cancel") {
                customCancelIsPresented = true
            }
            Button("Scrolling") {
                scrollingIsPresented = true
            }
            Divider()
            Text("Present with data")
            Button("Data: \(String(describing: data))") {
                if data == nil {
                    data = 1
                } else {
                    data = data! + 1
                }
            }
            Button("Nil Data") {
                data = nil
            }
            Button("Present") {
                dataIsPresented = true
            }
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "ConfirmationDialogPlayground.swift")
        }
        .confirmationDialog("Title", isPresented: $defaultIsPresented) {
            ConfirmationDialogDestructiveButton(value: $value)
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $titleIsPresented, titleVisibility: .visible) {
            ConfirmationDialogDestructiveButton(value: $value)
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $titleMessageIsPresented, titleVisibility: .visible) {
            ConfirmationDialogDestructiveButton(value: $value)
            Button("Option") {
                value = "Option"
            }
        } message: {
            Text("This is the message")
        }
        .confirmationDialog("Title", isPresented: $customCancelIsPresented) {
            ConfirmationDialogCancelButton(value: $value)
            ConfirmationDialogDestructiveButton(value: $value)
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $scrollingIsPresented) {
            ConfirmationDialogDestructiveButton(value: $value)
            ForEach(0..<20) { i in
                Button("Option \(i)") {
                    value = "Option \(i)"
                }
            }
        }
        .confirmationDialog("Title", isPresented: $dataIsPresented, presenting: data) { d in
            Button("Data: \(d)") {
                value = "\(d)"
            }
            Button("Nil Data", role: .destructive) {
                data = nil
            }
        }
    }
}

struct ConfirmationDialogCancelButton : View {
    @Binding var value: String

    var body: some View {
        Button("Cancel", role: .cancel) {
            value = "Custom Cancel"
        }
    }
}

struct ConfirmationDialogDestructiveButton : View {
    @Binding var value: String

    var body: some View {
        Button("Destructive", role: .destructive) {
            value = "Destructive"
        }
    }
}
