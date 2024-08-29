// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GraphicsPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Standard")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                }
                HStack {
                    Text(".grayscale(0.99)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.99)
                }
                HStack {
                    Text(".grayscale(0.25)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.25)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GraphicsPlayground.swift")
        }
    }
}
