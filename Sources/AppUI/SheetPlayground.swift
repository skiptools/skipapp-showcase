// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SheetPlayground: View {
    @State var isPresented = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Button("Present sheet") {
                isPresented = true
            }
            .padding()
            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
        .sheet(isPresented: $isPresented) {
            SheetPlayground()
        }
    }
}

