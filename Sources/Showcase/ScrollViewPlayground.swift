// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum ScrollViewPlaygroundType: String, CaseIterable {
    case vertical
    case horizontal
    case readerLazyVStack
    case readerLazyHStack
    case readerList
    case readerStaticList
    case readerLazyVGrid
    case readerLazyHGrid

    var title: String {
        switch self {
        case .vertical:
            return "Vertical"
        case .horizontal:
            return "Horizontal"
        case .readerLazyVStack:
            return "ScrollViewReader: LazyVStack"
        case .readerLazyHStack:
            return "ScrollViewReader: LazyHStack"
        case .readerList:
            return "ScrollViewReader: ForEach List"
        case .readerStaticList:
            return "ScrollViewReader: Static List"
        case .readerLazyVGrid:
            return "ScrollViewReader: LazyVGrid"
        case .readerLazyHGrid:
            return "ScrollViewReader: LazyHGrid"
        }
    }
}

struct ScrollViewPlayground: View {
    var body: some View {
        List(ScrollViewPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "ScrollViewPlayground.swift")
        }
        .navigationDestination(for: ScrollViewPlaygroundType.self) {
            switch $0 {
            case .vertical:
                VerticalScrollViewPlayground()
                    .navigationTitle($0.title)
            case .horizontal:
                HorizontalScrollViewPlayground()
                    .navigationTitle($0.title)
            case .readerLazyVStack:
                ScrollViewReaderLazyVStackPlayground()
                    .navigationTitle($0.title)
            case .readerLazyHStack:
                ScrollViewReaderLazyHStackPlayground()
                    .navigationTitle($0.title)
            case .readerList:
                ScrollViewReaderListPlayground()
                    .navigationTitle($0.title)
            case .readerStaticList:
                ScrollViewReaderStaticListPlayground()
                    .navigationTitle($0.title)
            case .readerLazyVGrid:
                ScrollViewReaderLazyVGridPlayground()
                    .navigationTitle($0.title)
            case .readerLazyHGrid:
                ScrollViewReaderLazyHGridPlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

private struct VerticalScrollViewPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<30) { i in
                    Text("View: \(i)")
                        .padding()
                }
            }
        }
    }
}

private struct HorizontalScrollViewPlayground: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<30) { i in
                    Text("View: \(i)")
                        .padding()
                }
            }
        }
    }
}

private struct ScrollViewReaderLazyVStackPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView {
                    LazyVStack {
                        ForEach(0..<30, id: \.self) { i in
                            Text("View: \(i)")
                                .padding()
                        }
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderLazyHStackPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<30, id: \.self) { i in
                            Text("View: \(i)")
                                .padding()
                        }
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderListPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                List {
                    Section("Section 0") {
                        ForEach(0..<10, id: \.self) { i in
                            Text("View: \(i)")
                        }
                    }
                    Section("Section 1") {
                        ForEach(10..<20, id: \.self) { i in
                            Text("View: \(i)")
                        }
                    }
                    Section("Section 2") {
                        ForEach(20..<30, id: \.self) { i in
                            Text("View: \(i)")
                        }
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderStaticListPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                List {
                    Section("Section 0") {
                        Text("View 0")
                            .id(0)
                        Text("View 1")
                            .id(1)
                        Text("View 2")
                            .id(2)
                        Text("View 3")
                            .id(3)
                        Text("View 4")
                            .id(4)
                        Text("View 5")
                            .id(5)
                        Text("View 6")
                            .id(6)
                        Text("View 7")
                            .id(7)
                        Text("View 8")
                            .id(8)
                        Text("View 9")
                            .id(9)
                    }
                    Section("Section 1") {
                        Text("View 10")
                            .id(10)
                        Text("View 11")
                            .id(11)
                        Text("View 12")
                            .id(12)
                        Text("View 13")
                            .id(13)
                        Text("View 14")
                            .id(14)
                        Text("View 15")
                            .id(15)
                        Text("View 16")
                            .id(16)
                        Text("View 17")
                            .id(17)
                        Text("View 18")
                            .id(18)
                        Text("View 19")
                            .id(19)
                    }
                    Section("Section 2") {
                        Text("View 20")
                            .id(20)
                        Text("View 21")
                            .id(21)
                        Text("View 22")
                            .id(22)
                        Text("View 23")
                            .id(23)
                        Text("View 24")
                            .id(24)
                        Text("View 25")
                            .id(25)
                        Text("View 26")
                            .id(26)
                        Text("View 27")
                            .id(27)
                        Text("View 28")
                            .id(28)
                        Text("View 29")
                            .id(29)
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderLazyVGridPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(0..<30) { index in
                            ZStack {
                                Color.yellow
                                Text(String(describing: index))
                            }
                            .frame(height: 200)
                        }
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderLazyHGridPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(0..<30) { index in
                            ZStack {
                                Color.yellow
                                Text(String(describing: index))
                            }
                            .frame(width: 200)
                        }
                    }
                }
                .border(.primary, width: 1)
            }
        }
    }
}

private struct ScrollViewReaderJumpButtons: View {
    let proxy: ScrollViewProxy

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Button("Scroll to 0") {
                    proxy.scrollTo(0)
                }
                Button("Animated") {
                    withAnimation { proxy.scrollTo(0) }
                }
            }
            .padding(.top)
            HStack(spacing: 16) {
                Button("Scroll to 15") {
                    proxy.scrollTo(15)
                }
                Button("Animated") {
                    withAnimation { proxy.scrollTo(15) }
                }
            }
            HStack(spacing: 16) {
                Button("Scroll to 29") {
                    proxy.scrollTo(29)
                }
                Button("Animated") {
                    withAnimation { proxy.scrollTo(29) }
                }
            }
        }
    }
}
