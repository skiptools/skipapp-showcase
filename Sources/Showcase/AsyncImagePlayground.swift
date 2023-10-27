// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct AsyncImagePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text("Basic:")
                    Spacer()
                    AsyncImage(url: URL(string: "https://picsum.photos/id/237/200/300"))
                        .border(Color.blue)
                }
                HStack {
                    Text("scale: 2.0:")
                    Spacer()
                    AsyncImage(url: URL(string: "https://picsum.photos/id/237/200/300"), scale: 2.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".frame(150, 150):")
                    Spacer()
                    AsyncImage(url: URL(string: "https://picsum.photos/id/237/200/300"))
                        .frame(width: 150.0, height: 150.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable(), .frame(150, 150):")
                    Spacer()
                    AsyncImage(url: URL(string: "https://picsum.photos/id/237/200/300")) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .frame(width: 150.0, height: 150.0)
                    .border(Color.blue)
                }
                HStack {
                    Text("No URL:")
                    Spacer()
                    AsyncImage(url: nil)
                        .border(Color.blue)
                }
                HStack {
                    Text("No URL, .frame(150, 150):")
                    Spacer()
                    AsyncImage(url: nil)
                        .frame(width: 150.0, height: 150.0)
                        .border(Color.blue)
                }
                HStack {
                    Text("Custom placeholder:")
                    Spacer()
                    AsyncImage(url: nil) { image in
                        EmptyView()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150.0, height: 150.0)
                    .border(Color.blue)
                }
                HStack {
                    Text("Custom phase closure:")
                    Spacer()
                    AsyncImage(url: nil) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .failure:
                            Color.red
                        case .success:
                            EmptyView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 150.0, height: 150.0)
                    .border(Color.blue)
                }
            }
        }
        .padding()
    }
}
