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
            VStack(spacing: 16.0) {
                Text("Button")
                    .font(.title)
                Divider()
                Button(action: { tapCount += 1 }) {
                    Text("ViewBuilder init: \(tapCount)")
                }
                Button("String init: \(tapCount)") {
                    tapCount += 1
                }
                Button(".plain: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.plain)
                Button(".bordered: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                Button(".foregroundStyle(Color.green): \(tapCount)") {
                    tapCount += 1
                }
                .foregroundStyle(Color.green)
            }
            .padding()
        }
    }
}
