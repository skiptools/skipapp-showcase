// Copyright 2025 Skip
import SwiftUI

struct FocusStatePlayground: View {
    @State var textA = ""
    @State var textB = ""
    @State var textC = ""

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
            
            ChildTextField(
                title: "textC",
                value: $textC,
                focusedField: $focusEnum,
                assignedFocusField: FocusField.textC
            )
            
            Button("Set focus to A via Boolean") { focusBool = true }
            Button("Set focus to A via Enum") { focusEnum = .textA }
            Button("Set focus to B via Enum") { focusEnum = .textB }
            Button("Set focus to C via Enum") { focusEnum = .textC }
            Button("Nil Enum") { focusEnum = nil }
        }
    }
}

struct ChildTextField: View {
    
    let title: String
    @Binding var value: String
    
    #if !SKIP
    @FocusState.Binding var focusedField: FocusField?
    #else
    @Binding var focusedField: FocusField?
    #endif
    let assignedFocusField: FocusField
    
    var body: some View {
        TextField(title, text: $value)
            .focused($focusedField, equals: assignedFocusField)
    }
}

enum FocusField: Int {
    case textA
    case textB
    case textC
}
