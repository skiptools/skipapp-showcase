// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ConfirmationDialogPlayground: View {
    @State var value = ""
    @State var isPresented = false

    var body: some View {
        VStack {
            Text(value).bold()
            Button("Default") {
                isPresented = true
            }
        }
        .confirmationDialog("Title", isPresented: $isPresented, titleVisibility: .visible) {
            Button("Option 1") {
                value = "Option 1"
            }
            Button("Option 2") {
                value = "Option 2"
            }
        }
    }
}
