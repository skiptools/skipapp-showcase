// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import Foundation
import SwiftUI

private let systemNameSample = "heart.fill"
private let remoteImageResourceURL: URL? = URL(string: "https://picsum.photos/id/237/200/300")
// iOS: file://…/Application/…/Showcase.app/skipapp-showcase_Showcase.bundle/skip-logo.png
// Android: jar:file:/data/app/…/base.apk!/showcase/module/Resources/skip-logo.png
private let localImageResourceURL: URL? = Bundle.module.url(forResource: "skip-logo", withExtension: "png")

struct ImagePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                NavigationLink("Pager") {
                    ImagePlaygroundPagerView()
                }

                Text("Asset Image").font(.title).bold()
                HStack {
                    Spacer()
                    Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .border(.yellow, width: 5.0)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
                    Spacer()
                }

                Text("Bundled Image").font(.title).bold()
                HStack {
                    Spacer()
                    AsyncImage(url: localImageResourceURL)
                        .border(.blue)
                    Spacer()
                }

                Text("Symbol Image Weights").font(.title).bold()
                HStack {
                    // Image(systemName:) will load the SVG from the Module.xcassets/face.dashed.fill.symbolset/face.dashed.fill.svg file on Android, but use the named system image on iOS
                    Image(systemName: "face.dashed.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.red)
                        .fontWeight(.ultraLight)
                        .frame(width: 80.0, height: 80.0)
                    // named images will load the SVG from the Module.xcassets/face.dashed.fill.svg file on both iOS and Android
                    Image("face.dashed.fill", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.green)
                        .frame(width: 80.0, height: 80.0)
                    Image("face.dashed.fill", bundle: .module, label: Text("Smiley Face"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.blue)
                        .fontWeight(.black)
                        .frame(width: 80.0, height: 80.0)
                }

                Text("Symbol Image Sizes").font(.title).bold()
                HStack {
                    Image("textformat.size.smaller", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0, height: 80.0)
                    Image("textformat.size", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0, height: 80.0)
                    Image("textformat.size.larger", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0, height: 80.0)
                }


                Text("systemName").font(.title).bold()
                HStack {
                    Text(".frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFill\n.frame(100, 100)\n.clipped")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFit\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fill)\n.frame(100, 100)\n.clipped")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(0.33, contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fit)\n.frame(100, 100)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(0.33, contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(3, .fit)\n.frame(100, 100)\n.foregroundStyle(.red)")
                    Spacer()
                    Image(systemName: systemNameSample)
                        .resizable()
                        .aspectRatio(3, contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.red)
                        .border(Color.blue)
                }

                Text("AsyncImage").font(.title).bold()
                HStack {
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL)
                        .border(Color.blue)
                }
                HStack {
                    Text("scale: 2")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL, scale: 2)
                        .border(Color.blue)
                }
                HStack {
                    Text(".frame(100, 100)")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL)
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text(".frame(100, 100)\nclipped")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .frame(width: 100, height: 100)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFill\n.frame(100, 100)\n.clipped")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.scaleToFit\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fill)\n.frame(100, 100)\n.clipped")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(0.33, contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(0.33, .fit)\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(0.33, contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .border(Color.blue)
                }
                HStack {
                    Text(".resizable()\n.aspectRatio(3, .fit)\n.frame(100, 100)")
                    Spacer()
                    AsyncImage(url: remoteImageResourceURL) { image in
                        image.resizable()
                    } placeholder: {
                    }
                    .aspectRatio(3, contentMode: .fit)
                    .frame(width: 100, height: 100)
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
                        .frame(width: 100, height: 100)
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
                    .frame(width: 100, height: 100)
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
                    .frame(width: 100, height: 100)
                    .border(Color.blue)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ImagePlayground.swift")
        }
    }
}

private struct ImagePlaygroundPagerView: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0..<10) { _ in
                        AsyncImage(url: remoteImageResourceURL) { image in
                            image.resizable()
                        } placeholder: {
                        }
                        .scaledToFit()
                        .padding(.horizontal, 20)
                        .frame(width: proxy.size.width)
                        .clipped()
                    }
                }
            }
            .modifier(PagingModifier())
        }
    }
}

struct PagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if !SKIP
        if #available(iOS 17.0, macOS 14.0, *) {
            content
                .scrollTargetBehavior(.paging)
        } else {
            content
        }
        #else
        content
        #endif
    }
}
