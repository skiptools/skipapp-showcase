// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct StackPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text("Before fixed")
                        .border(Color.blue)
                    HStack {
                        Spacer()
                        Text("After expanding")
                    }
                    .border(Color.red)
                    Text("After fixed")
                        .border(Color.blue)
                }
                VStack {
                    Text("Text1")
                    Text("Text2")
                }
                .border(Color.blue)
                VStack {
                    Color.red.frame(width: 50.0, height: 50.0)
                    Color.green.frame(width: 50.0, height: 50.0)
                }
                .border(Color.blue)
                VStack {
                    Text("Text1")
                    Color.green.frame(width: 50.0, height: 50.0)
                }
                .border(Color.blue)
                VStack {
                    Color.red.frame(width: 50.0, height: 50.0)
                    Text("Text2")
                }
                .border(Color.blue)
            }
            .padding()
        }
    }
}
