// Copyright 20222 Skip
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
            VStack {
                Text("Spacer")
                    .font(.title)
                Divider()

                Text("State tap count: \(tapCount)")
                    .padding()
                Button("State") {
                    tapCount += 1
                }
                .padding()

                Divider()

                Text("Object tap count: \(tapCountObject.tapCount)")
                    .padding()
                Button("Object") {
                    tapCountObject.tapCount += 1
                }
                .padding()

                Divider()
                
                NavigationLink("Push another", value: PlaygroundType.state)
                    .padding()
            }
        }
    }
}
