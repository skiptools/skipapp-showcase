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
            VStack(spacing: 16.0) {
                Text("TextField")
                    .font(.title)
                Divider()
                TextField(text: $text) {
                    Text("Viewbuilder init")
                }
                TextField("String init", text: $text)
                TextField("With prompt", text: $text, prompt: Text("Prompt"))
                TextField("Fixed width", text: $text)
                    .frame(width: 200.0)
            }
            .padding()
        }
    }
}
