// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct FramePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                VStack {
                    Text("width: 100, height: 50")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(width: 100.0, height: 50.0)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 0, maxWidth: .infinity,\n  minHeight: 0, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 0, maxWidth: .infinity,\n  minHeight: 0, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Color.blue
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 300, maxWidth: .infinity,\n  minHeight: 100, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 300.0, maxWidth: .infinity, minHeight: 100.0, maxHeight: .infinity)
                        Color.blue
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("minWidth: 100,\n  minHeight: 0, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(minWidth: 100.0, minHeight: 0.0, maxHeight: .infinity)
                        Color.blue
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Text("B")
                    }
                }
                VStack {
                    Text("idealWidth: 100,\n  minHeight: 0, maxHeight: .infinity")
                    HStack {
                        Text("A")
                        Color.red
                            .frame(idealWidth: 100.0, minHeight: 0.0, maxHeight: .infinity)
                        Color.blue
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Text("B")
                    }
                }
            }
            .padding()
        }
    }
}
