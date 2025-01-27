// Copyright 2025 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct FocusStatePlayground: View {
    @State var textA = ""
    @State var textB = ""

    @FocusState var focusBool: Bool
    @FocusState var focusEnum: FocusField?

    var body: some View {
        Form {
            NavigationLink("Push") { Text("Pushed") }
            Text("Boolean: \(focusBool.description)")
            Text("Enum: \(focusEnum == .textA ? "A" : (focusEnum == .textB ? "B" : "nil"))")
            TextField("textA", text: $textA)
               .focused($focusBool)
               .focused($focusEnum, equals: .textA)
            TextField("textB", text: $textB)
                .focused($focusEnum, equals: .textB)
            Button("Set focus to A via Boolean") { focusBool = true }
            Button("Set focus to A via Enum") { focusEnum = .textA }
            Button("Set focus to B via Enum") { focusEnum = .textB }
            Button("Nil Enum") { focusEnum = nil }
        }
    }
}

enum FocusField: Int {
    case textA
    case textB
}
