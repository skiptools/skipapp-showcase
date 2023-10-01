// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

class TapCount: ObservableObject {
    @Published var tapCount = 0
}

struct StatePlayground: View {
    @State var tapCount = 0
    @StateObject var tapCountObject = TapCount()

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("State")
                    .font(.title)
                Divider()

                Text("State tap count: \(tapCount)")
                Button("State") {
                    tapCount += 1
                }

                Divider()

                Text("Object tap count: \(tapCountObject.tapCount)")
                Button("Object") {
                    tapCountObject.tapCount += 1
                }

                Divider()
                
                NavigationLink("Push another", value: PlaygroundType.state)
            }
        }
    }
}
