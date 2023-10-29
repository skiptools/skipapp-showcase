// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import Foundation
import SwiftUI

struct ImagePlayground: View {
    let systemNameSample = "heart.fill"
    let asyncImageSample = "https://picsum.photos/id/237/200/300"

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("systemName").font(.title).bold()
                HStack {
                    Text(".frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFill\n.frame(100, 100)\n.clipped")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100.0, height: 100.0)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFit\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fill)\n.frame(100, 100)\n.clipped")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(0.33, contentMode: .fill)
                        .frame(width: 100.0, height: 100.0)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fit)\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(0.33, contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(3, .fit)\n.frame(100, 100)\n.foregroundStyle(Color.red)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(3.0, contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                        .foregroundStyle(Color.red)
                        .border(Color.blue)
                }

                Text("AsyncImage").font(.title).bold()
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample))
                        .border(Color.blue)
                }
                HStack {
                    Text("scale: 2.0")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample), scale: 2.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".frame(100, 100)")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample))
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text(".frame(100, 100)\nclipped")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample))
                        .frame(width: 100.0, height: 100.0)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFill\n.frame(100, 100)\n.clipped")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .scaledToFill()
                    .frame(width: 100.0, height: 100.0)
                    .clipped()
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFit\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .scaledToFit()
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fill)\n.frame(100, 100)\n.clipped")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(0.33, contentMode: .fill)
                    .frame(width: 100.0, height: 100.0)
                    .clipped()
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fit)\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(0.33, contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(3, .fit)\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: URL(string: asyncImageSample)) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(3.0, contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
                HStack {
                    Text("No URL")
                    Spacer()
                    AsyncImage(url: nil)
                        .border(Color.blue)
                }
                HStack {
                    Text("No URL\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: nil)
                        .frame(width: 100.0, height: 100.0)
                        .border(Color.blue)
                }
                HStack {
                    Text("Custom placeholder")
                    Spacer()
                    AsyncImage(url: nil) { image in
                        EmptyView()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
                HStack {
                    Text("Custom closure")
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
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue)
                }
            }
        }
        .padding()
    }
}
