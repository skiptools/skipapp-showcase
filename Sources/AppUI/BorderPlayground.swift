// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct BorderPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Border")
                    .font(.title)
                Divider()
                HStack {
                    Text("Black")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.black)
                }
                HStack {
                    Text(".padding()")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .padding()
                        .border(Color.black)
                }
                HStack {
                    Text(".padding([.top, .leading])")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .padding([.top, .leading], 32.0)
                        .border(Color.black)
                }
                HStack {
                    Text("Blue, 5.0")
                    Spacer()
                    Color.red
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue, width: 5.0)
                }
                HStack {
                    Text("VStack")
                    Spacer()
                    VStack {
                        Color.red
                            .frame(width: 100.0, height: 100.0)
                            .padding()
                        Color.red
                            .frame(width: 100.0, height: 100.0)
                            .padding()
                    }
                    .border(Color.black)
                }
            }
            .padding()
        }
    }
}
