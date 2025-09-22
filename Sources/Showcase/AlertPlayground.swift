// Copyright 2023–2025 Skip
import Foundation
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
    @State var textFieldIsPresented = false
    @State var secureFieldIsPresented = false
    @State var textFieldText = ""
    @State var secureFieldText = ""
//    @State var errorIsPresented = false
    @State var dataIsPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Text(value).bold()
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
            Divider()
            Button("Text Field") {
                textFieldIsPresented = true
            }
            Button("Secure Field") {
                secureFieldIsPresented = true
            }
            Divider()
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
//            Divider()
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
            AlertCancelButton(value: $value)
        }
        .alert("Three Buttons", isPresented: $threeButtonsIsPresented) {
            AlertCancelButton(value: $value)
            Button("Option") {
                value = "Option"
            }
            AlertDestructiveButton(value: $value)
        }
        .alert("Five Buttons", isPresented: $fiveButtonsIsPresented) {
            AlertCancelButton(value: $value)
            AlertDestructiveButton(value: $value)
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
        .alert("Text Field", isPresented: $textFieldIsPresented) {
            TextField("Enter text", text: $textFieldText)
            Button("Submit") {
                value = textFieldText
            }
            AlertCancelButton(value: $value)
        }
        .alert("Sign In", isPresented: $secureFieldIsPresented) {
            TextField("Username", text: $textFieldText)
            SecureField("Password", text: $secureFieldText)
            Button("Submit") {
                value = textFieldText
            }
            AlertCancelButton(value: $value)
        }
        .alert("Data", isPresented: $dataIsPresented, presenting: data) { d in
            Button("Data: \(d)") {
                value = "\(d)"
            }
            Button("Nil Data", role: .destructive) {
                data = nil
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
    }
}

enum AlertPlaygroundError: LocalizedError {
    case testError
}

struct AlertCancelButton : View {
    @Binding var value: String

    var body: some View {
        Button("Cancel", role: .cancel) {
            value = "Custom Cancel"
        }
    }
}

struct AlertDestructiveButton : View {
    @Binding var value: String

    var body: some View {
        Button("Destructive", role: .destructive) {
            value = "Destructive"
        }
    }
}
