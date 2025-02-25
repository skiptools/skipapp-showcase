// Copyright 2023–2025 Skip
import SwiftUI

struct OnSubmitPlayground: View {
    @State var text1 = ""
    @State var text2 = ""
    @State var submitText = ""

    var body: some View {
        Form {
            HStack {
                Text(submitText)
                Spacer()
                Button("Clear") {
                    submitText = ""
                }
            }
            TextField("Text1", text: $text1)
                .onSubmit {
                    submitText = submitText + "Text1 "
                }
            TextField("Text2", text: $text2)
                .onSubmit {
                    submitText = submitText + "Text2 "
                }
        }
        .onSubmit {
            submitText = submitText + "Form "
        }
        .toolbar {
            PlaygroundSourceLink(file: "OnSubmitPlayground.swift")
        }
    }
}
