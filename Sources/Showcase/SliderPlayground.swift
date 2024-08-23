// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SliderPlayground: View {
    @State var value = 0.0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Value: \(value)").bold().font(.title)
                Divider()
                Slider(value: $value)
                HStack {
                    Text("in: 0...2 step 0.5")
                    Slider(value: $value, in: 0...2, step: 0.5)
                }
                HStack {
                    Text("in: 0...1000 step 25")
                    Slider(value: $value, in: 0...1000, step: 25)
                }
                HStack {
                    Text(".disabled(true)")
                    Slider(value: $value)
                        .disabled(true)
                }
                HStack {
                    Text(".foregroundStyle(.red)")
                    Slider(value: $value)
                        .foregroundStyle(.red)
                }
                HStack {
                    Text(".tint(.red)")
                    Slider(value: $value)
                        .tint(.red)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "SliderPlayground.swift")
        }
    }
}
