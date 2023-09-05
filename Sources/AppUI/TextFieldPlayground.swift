// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TextFieldPlayground: View {
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack {
                Text("TextField")
                    .font(.title)
                Divider()
                TextField(text: $text) {
                    Text("Viewbuilder init")
                }
                .padding([.top, .bottom])
                TextField("String init", text: $text)
                    .padding([.bottom])
                TextField("With prompt", text: $text, prompt: Text("Prompt"))
                    .padding([.bottom])
                TextField("Fixed width", text: $text)
                    .frame(width: 200.0)
            }
            .padding()
        }
    }
}
