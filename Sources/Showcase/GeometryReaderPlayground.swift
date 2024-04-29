// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GeometryReaderPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Size").bold()
                GeometryReader { proxy in
                    HStack(spacing: 0) {
                        Text("1/3")
                            .font(.largeTitle)
                            .frame(width: proxy.size.width * 0.33)
                            .background(.blue)
                        Text("2/3")
                            .font(.largeTitle)
                            .frame(width: proxy.size.width * 0.67)
                            .background(.red)
                    }
                }
                .frame(height: 50)
                Text("Frame").bold()
                GeometryReader { proxy in
                    VStack {
                        Text("Local frame: \(string(for: proxy.frame(in: .local)))")
                        Text("Global frame: \(string(for: proxy.frame(in: .global)))")
                    }
                }
                .background(.yellow)
                .padding()
                .border(.blue)
                .frame(height: 100)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GeometryReaderPlayground.swift")
        }
    }

    private func string(for rect: CGRect) -> String {
        return "(\(Int(rect.minX)), \(Int(rect.minY)), \(Int(rect.width)), \(Int(rect.height)))"
    }
}

