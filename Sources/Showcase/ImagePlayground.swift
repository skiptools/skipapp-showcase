// Copyright 2023–2025 Skip
import Foundation
import SwiftUI

private let systemNameSample = "heart.fill"
private let remoteImageResourceURL: URL? = URL(string: "https://picsum.photos/id/237/200/300")
// iOS: file://…/Application/…/Showcase.app/skipapp-showcase_Showcase.bundle/skip-logo.png
// Android: jar:file:/data/app/…/base.apk!/showcase/module/Resources/skip-logo.png
private let localImageResourceURL: URL? = Bundle.module.url(forResource: "skip-logo", withExtension: "png")

struct ImagePlayground: View {
    var redaction: RedactionReasons = []

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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
                    Text("Just green")
                    Spacer()
                    Color.green
                        #if SKIP
                        .composeModifier { $0.logLayout2("Color") }
                        #endif
                        .aspectRatio(3.0/4.0, contentMode: .fit)
                        .border(Color.blue)
                }
                #if SKIP
                .composeModifier { $0.logLayout("Color HStack") }
                #endif
                HStack {
                    Text("No URL\n.aspectRatio(3/4)")
                    Spacer()
                    AsyncImage(url: nil)  { image in
                            EmptyView()
                        } placeholder: {
                            Color.green
                            #if SKIP
                            .composeModifier { $0.logLayout("Placeholder") }
                            #endif
                        }
                        #if SKIP
                        .composeModifier { $0.logLayout("AsyncImage") }
                        #endif
                        .aspectRatio(3.0/4.0, contentMode: .fit)
                        .border(Color.blue)
                }
                HStack {
                    Text("No URL\n.aspectRatio(3/4).frame(100)")
                    Spacer()
                    AsyncImage(url: nil)
                        .aspectRatio(3.0/4.0, contentMode: .fit)
                        .frame(width: 100)
                        .border(Color.blue)
                }
                HStack {
                    Text("Failed URL\n.aspectRatio(3/4)")
                    Spacer()
                    AsyncImage(url: URL(string: "file:///does_not_exist.png")!)
                        .aspectRatio(3.0/4.0, contentMode: .fit)
                        .border(Color.blue)
                }
                HStack {
                    Text("Failed URL\n.aspectRatio(3/4).frame(100)")
                    Spacer()
                    AsyncImage(url: URL(string: "file:///does_not_exist.png")!)
                        .aspectRatio(3.0/4.0, contentMode: .fit)
                        .frame(width: 100)
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
        .redacted(reason: redaction)
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

private struct ImagePlaygroundComplexLayoutView: View {
    let imageName: String

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    VStack {
                        Text("Header")
                        Spacer()
                        Image(imageName, bundle: .module)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .border(Color.pink)
                        Spacer()
                        Text("Body")
                        Spacer()
                        Text("Footer")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color.cyan)
                }
                .frame(minHeight: geometry.size.height, alignment: .topLeading)
            }
        }
    }
}

#if SKIP
import androidx.compose.ui.Modifier

extension Modifier {
    /// Log layout constraints for debugging purposes.
    ///
    /// - Parameter tag: The log tag to use (default: "LogLayout").
    /// - Returns: A modifier that logs layout constraints and bounds.
    ///
    public func logLayout2(tag: String = "LogLayout") -> Modifier {
        return self.logLayoutModifier2(tag: tag)
    }
}


#endif