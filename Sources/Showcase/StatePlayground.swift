// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

class TapCountObservable: ObservableObject {
    @Published var tapCount = 0
}

struct TapCountStruct {
    var tapCount = 0
}

struct StatePlayground: View {
    @State var tapCount = 0
    @State var hasStateTapped: Bool? // Test optional vars
    @StateObject var tapCountObservable = TapCountObservable()
    @State var tapCountStruct = TapCountStruct()

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                if hasStateTapped == true {
                    Text("State tap count: \(tapCount)")
                } else {
                    Text("Tap below to increment state tap count")
                }
                Button("State") {
                    tapCount += 1
                    hasStateTapped = true
                }
                StatePlaygroundBindingView(tapCount: $tapCount)

                Divider()

                Text("Observable tap count: \(tapCountObservable.tapCount)")
                Button("Observable") {
                    tapCountObservable.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountObservable.tapCount)

                Divider()

                Text("Struct tap count: \(tapCountStruct.tapCount)")
                Button("Struct") {
                    tapCountStruct.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountStruct.tapCount)

                Divider()
                
                NavigationLink("Push another", value: PlaygroundType.state)
            }
            .padding()
            .onChange(of: tapCount) {
                logger.log("onChange(of: tapCount): \($0)")
            }
            .onChange(of: tapCountObservable.tapCount) {
                logger.log("onChange(of: tapCountObservable.tapCount): \($0)")
            }
            .onChange(of: tapCountStruct.tapCount) {
                logger.log("onChange(of: tapCountStruct.tapCount): \($0)")
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "StatePlayground.swift")
        }
    }
}

struct StatePlaygroundBindingView: View {
    @Binding var tapCount: Int
    var body: some View {
        Button("Binding") {
            tapCount += 1
        }
    }
}

