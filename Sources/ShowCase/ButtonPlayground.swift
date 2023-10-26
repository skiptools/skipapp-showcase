// Copyright 2023 Skip
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
                Button(".borderedProminent: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                Button(".foregroundStyle(Color.red): \(tapCount)") {
                    tapCount += 1
                }
                .foregroundStyle(Color.red)
                Button(".tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .tint(.red)
                Button(".bordered, .foregroundStyle(Color.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                .foregroundStyle(Color.red)
                Button(".bordered, .tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                .tint(.red)
                Button(".borderedProminent, .foregroundStyle(Color.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(Color.red)
                Button(".borderedProminent, .tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding()
        }
    }
}
