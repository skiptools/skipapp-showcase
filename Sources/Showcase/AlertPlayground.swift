// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct AlertPlayground: View {
    @State var value = ""
    @State var error: AlertPlaygroundError? = nil
    @State var data: Int? = nil
    @State var titleIsPresented = false
    @State var titleMessageIsPresented = false
    @State var twoButtonsIsPresented = false
    @State var threeButtonsIsPresented = false
    @State var fiveButtonsIsPresented = false
//    @State var errorIsPresented = false
    @State var dataIsPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Text(value).bold()
            Group {
                Button("Title") {
                    titleIsPresented = true
                }
                Button("Title + Message") {
                    titleMessageIsPresented = true
                }
                Button("Two Buttons") {
                    twoButtonsIsPresented = true
                }
                Button("Three Buttons") {
                    threeButtonsIsPresented = true
                }
                Button("Five Buttons") {
                    fiveButtonsIsPresented = true
                }
            }
            Divider()
//            Group {
//                Text("Present with error")
//                Button("Error: \(String(describing: error))") {
//                    error = AlertPlaygroundError.testError
//                }
//                Button("Nil error") {
//                    error = nil
//                }
//                Button("Present") {
//                    errorIsPresented = true
//                }
//            }
//            Divider()
            Group {
                Text("Present with data")
                Button("Data: \(String(describing: data))") {
                    if data == nil {
                        data = 1
                    } else {
                        data = data! + 1
                    }
                }
                Button("Nil data") {
                    data = nil
                }
                Button("Present") {
                    dataIsPresented = true
                }
            }
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "AlertPlayground.swift")
        }
        .alert("Title", isPresented: $titleIsPresented) {
        }
        .alert("Title + Message", isPresented: $titleMessageIsPresented) {
        } message: {
            Text("This is the alert message to show beneath the title")
        }
        .alert("Two Buttons", isPresented: $twoButtonsIsPresented) {
            Button("Option") {
                value = "Option"
            }
            Button("Cancel", role: .cancel) {
                value = "Custom Cancel"
            }
        }
        .alert("Three Buttons", isPresented: $threeButtonsIsPresented) {
            Button("Cancel", role: .cancel) {
                value = "Custom Cancel"
            }
            Button("Option") {
                value = "Option"
            }
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
        }
        .alert("Five Buttons", isPresented: $fiveButtonsIsPresented) {
            Button("Cancel", role: .cancel) {
                value = "Custom Cancel"
            }
            Button("Destructive", role: .destructive) {
                value = "Destructive"
            }
            Button("Option 1") {
                value = "Option 1"
            }
            Button("Option 2") {
                value = "Option 2"
            }
            Button("Option 3") {
                value = "Option 3"
            }
        }
//        .alert(isPresented: $errorIsPresented, error: error) {
//            Button("Error: \(String(describing: error))") {
//                value = "\(String(describing: error))"
//            }
//            Button("Nil Error", role: .destructive) {
//                error = nil
//            }
//        }
        .alert("Data", isPresented: $dataIsPresented, presenting: data) { d in
            Button("Data: \(d)") {
                value = "\(d)"
            }
            Button("Nil Data", role: .destructive) {
                data = nil
            }
        }
    }
}

enum AlertPlaygroundError: LocalizedError {
    case testError
}
