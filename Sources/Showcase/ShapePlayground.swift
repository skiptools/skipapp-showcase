// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ShapePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                //~~~
                #if !SKIP
                HStack {
                    Text("Circle.fill()")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("Circle.offset(20.0, 20.0).fill()")
                    Spacer()
                    ZStack {
                        Circle()
                            .offset(x: 20.0, y: 20.0)
                            .fill()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                #endif
            }.padding()
        }
    }
}
