// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct BackgroundPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text(".red")
                    Spacer()
                    ZStack {
                    }
                    .frame(width: 100.0, height: 100.0)
                    .background(.red)
                }
                HStack {
                    Text("background()")
                    Spacer()
                    ZStack {
                        Text("Hello")
                            .background()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .background(.red)
                }
                HStack {
                    Text(".red.gradient")
                    Spacer()
                    ZStack {
                    }
                    .frame(width: 100.0, height: 100.0)
                    .background(.red.gradient)
                }
                HStack {
                    Text(".backgroundStyle(.red)")
                    Spacer()
                    ZStack {
                        Text("Hello")
                            .background()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .backgroundStyle(.red)
                }
                HStack {
                    Text(".clipShape(.capsule)")
                    Spacer()
                    Image(systemName: "heart.fill")
                        .frame(width: 100.0, height: 50.0)
                        .background(.red.gradient)
                        .clipShape(.capsule)
                }
            }
            .padding()
        }
    }
}

