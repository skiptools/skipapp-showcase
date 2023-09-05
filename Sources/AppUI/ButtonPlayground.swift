// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ButtonPlayground: View {
    @State var tapCount = 0
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Button")
                    .font(.title)
                Divider()
                Button(action: { tapCount += 1 }) {
                    Text("ViewBuilder init: \(tapCount)")
                }
                .padding()
                Button("String init: \(tapCount)") {
                    tapCount += 1
                }
            }
            .padding()
        }
    }
}
