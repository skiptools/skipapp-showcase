// Copyright 2023–2026 Skip
import SwiftUI

enum ScrollViewPlaygroundType: String, CaseIterable {
    case vertical
    case horizontal
    case viewAligned
    case modifiers
    case carousel
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
        case .viewAligned:
            return ".viewAligned"
        case .modifiers:
            return "Modifiers"
        case .carousel:
            return "Carousel"
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
            case .viewAligned:
                ViewAlignedScrollViewPlayground()
                    .navigationTitle($0.title)
            case .modifiers:
                ScrollViewModifiersPlayground()
                    .navigationTitle($0.title)
            case .carousel:
                CarouselPlayground()
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

struct VerticalScrollViewPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<30) { i in
                    Text("View: \(i)")
                        .padding()
                }
            }
        }
        .refreshable {
            do { try await Task.sleep(nanoseconds: 3_000_000_000) } catch { }
        }
    }
}

struct HorizontalScrollViewPlayground: View {
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

struct ViewAlignedScrollViewPlayground: View {
    var body: some View {
        if #available(iOS 17, *) {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0..<20) { i in
                        ZStack {
                            Color.yellow
                            Text(String(describing: i))
                        }
                        .frame(width: 80, height: 80)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        } else {
            Text("Requires iOS 17+")
        }
    }
}

struct ScrollViewReaderLazyVStackPlayground: View {
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

struct ScrollViewReaderLazyHStackPlayground: View {
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

struct ScrollViewReaderListPlayground: View {
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

struct ScrollViewReaderStaticListPlayground: View {
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

struct ScrollViewReaderLazyVGridPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(0..<30, id: \.self) { index in
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

struct ScrollViewReaderLazyHGridPlayground: View {
    var body: some View {
        ScrollViewReader { proxy in
            VStack(spacing: 16) {
                ScrollViewReaderJumpButtons(proxy: proxy)
                    .padding([.top, .bottom])
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(0..<30, id: \.self) { index in
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

struct ScrollViewReaderJumpButtons: View {
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

struct ScrollViewModifiersPlayground: View {
    @State var isScrollDisabled = false
    @State var hideScrollIndicators = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Disable Scrolling", isOn: $isScrollDisabled)
                .padding(.horizontal)

            Text("scrollDisabled(\(isScrollDisabled ? "true" : "false"))")
                .font(.caption)
                .foregroundStyle(.secondary)

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .scrollDisabled(isScrollDisabled)
            .border(Color.gray)

            Divider()

            Toggle("Hide Scroll Indicators", isOn: $hideScrollIndicators)
                .padding(.horizontal)

            Text("scrollIndicators(\(hideScrollIndicators ? ".hidden" : ".automatic"))")
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("Note: Android Compose does not show scroll indicators by default")
                .font(.caption2)
                .foregroundStyle(.secondary)

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<10) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .scrollIndicators(hideScrollIndicators ? .hidden : .automatic)
            .frame(height: 150)
            .border(Color.gray)
        }
        .padding()
    }
}

struct CarouselPlayground: View {
    let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple, .pink
    ]
    @State var selectedId: AnyHashable? = 0

    var body: some View {
        if #available(iOS 17, *) {
            VStack(spacing: 20) {
                Text(selectedColorName)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(color)
                                Text(colorName(for: color))
                                    .font(.title)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 280, height: 400)
                        }
                    }
                    .padding(.horizontal, 16)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $selectedId)
            }
        } else {
            Text("Requires iOS 17+")
        }
    }

    var selectedColorName: String {
        guard let selectedId = selectedId as? Int, selectedId >= 0, selectedId < colors.count else {
            return ""
        }
        return colorName(for: colors[selectedId])
    }

    func colorName(for color: Color) -> String {
        switch color {
        case .red: return "Red"
        case .orange: return "Orange"
        case .yellow: return "Yellow"
        case .green: return "Green"
        case .blue: return "Blue"
        case .purple: return "Purple"
        case .pink: return "Pink"
        default: return ""
        }
    }
}
