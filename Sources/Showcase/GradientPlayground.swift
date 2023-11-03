// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GradientPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text(".red.gradient")
                    Spacer()
                    Text("Text").font(.largeTitle).foregroundStyle(.red.gradient)
                }
            }
            .padding()
        }
    }
}
