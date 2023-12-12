// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
        VStack(spacing: 16.0) {
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
        .confirmationDialog("Title", isPresented: $defaultIsPresented) {
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $titleIsPresented, titleVisibility: .visible) {
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $titleMessageIsPresented, titleVisibility: .visible) {
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
            Button("Option") {
                value = "Option"
            }
        } message: {
            Text("This is the message")
        }
        .confirmationDialog("Title", isPresented: $customCancelIsPresented) {
            Button("Custom Cancel", role: .cancel) {
                value = "Custom Cancel"
            }
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
            Button("Option") {
                value = "Option"
            }
        }
        .confirmationDialog("Title", isPresented: $scrollingIsPresented) {
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
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
