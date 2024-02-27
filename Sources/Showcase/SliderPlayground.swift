// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SliderPlayground: View {
    @State var value = 0.5

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Slider(value: $value)
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
