// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ZIndexPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text("Without zIndex")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .frame(width: 20.0, height: 20.0)
                        Color.green.opacity(0.5)
                            .frame(width: 60.0, height: 60.0)
                        Color.pink.opacity(0.5) //~~~
                            .frame(width: 100.0, height: 100.0)
                    }
                }
                HStack {
                    Text("With zIndex")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .frame(width: 20.0, height: 20.0)
                            .zIndex(2.0)
                        Color.green.opacity(0.5)
                            .frame(width: 60.0, height: 60.0)
                            .zIndex(1.0)
                        Color.red.opacity(0.5)
                            .frame(width: 100.0, height: 100.0)
                    }
                }
                HStack {
                    Text("With zIndex before frame")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .zIndex(2.0)
                            .frame(width: 20.0, height: 20.0)
                        Color.green.opacity(0.5)
                            .zIndex(1.0)
                            .frame(width: 60.0, height: 60.0)
                        Color.red.opacity(0.5)
                            .frame(width: 100.0, height: 100.0)
                    }
                }
            }
            .padding()
        }
    }
}
