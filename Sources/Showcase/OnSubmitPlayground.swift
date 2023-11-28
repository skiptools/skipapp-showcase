// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
    }
}
