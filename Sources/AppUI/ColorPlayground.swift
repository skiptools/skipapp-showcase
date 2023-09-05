// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ColorPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Color")
                    .font(.title)
                Divider()

                HStack {
                    Text("Red")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("Red, .opacity(0.5)")
                    Spacer()
                    Color.red
                        .opacity(0.5)
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("RGB")
                    Spacer()
                    Color(red: 1.0, green: 0.0, blue: 0.0)
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("White, Opacity")
                    Spacer()
                    Color(white: 0.5, opacity: 1.0)
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("Accent color")
                    Spacer()
                    Color.accentColor
                        .frame(width: 100.0, height: 100.0)
                }
            }
            .padding()
        }
    }
}
