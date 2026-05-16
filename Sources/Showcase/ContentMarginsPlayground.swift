// Copyright 2023–2026 Skip
import SwiftUI

enum ContentMarginsPlaygroundType: String, CaseIterable {
    case vstackUniform
    case vstackHorizontal
    case vstackInsets
    case lazyVStackUniform
    case lazyHStackHorizontal
    case listUniform
    case scrollContentPlacement
    case scrollIndicatorsPlacement
    case carouselViewAligned

    var title: String {
        switch self {
        case .vstackUniform:
            return "VStack: Uniform 40pt"
        case .vstackHorizontal:
            return "VStack: Horizontal 60pt"
        case .vstackInsets:
            return "VStack: EdgeInsets"
        case .lazyVStackUniform:
            return "LazyVStack: Uniform 40pt"
        case .lazyHStackHorizontal:
            return "LazyHStack: Horizontal 40pt"
        case .listUniform:
            return "List: Uniform 40pt"
        case .scrollContentPlacement:
            return "Placement: .scrollContent"
        case .scrollIndicatorsPlacement:
            return "Placement: .scrollIndicators"
        case .carouselViewAligned:
            return "Carousel: View Aligned"
        }
    }
}

struct ContentMarginsPlayground: View {
    var body: some View {
        List(ContentMarginsPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "ContentMarginsPlayground.swift")
        }
        .navigationDestination(for: ContentMarginsPlaygroundType.self) { type in
            switch type {
            case .vstackUniform:
                ContentMarginsVStackUniformPlayground()
                    .navigationTitle(type.title)
            case .vstackHorizontal:
                ContentMarginsVStackHorizontalPlayground()
                    .navigationTitle(type.title)
            case .vstackInsets:
                ContentMarginsVStackInsetsPlayground()
                    .navigationTitle(type.title)
            case .lazyVStackUniform:
                ContentMarginsLazyVStackUniformPlayground()
                    .navigationTitle(type.title)
            case .lazyHStackHorizontal:
                ContentMarginsLazyHStackHorizontalPlayground()
                    .navigationTitle(type.title)
            case .listUniform:
                ContentMarginsListUniformPlayground()
                    .navigationTitle(type.title)
            case .scrollContentPlacement:
                ContentMarginsScrollContentPlacementPlayground()
                    .navigationTitle(type.title)
            case .scrollIndicatorsPlacement:
                ContentMarginsScrollIndicatorsPlacementPlayground()
                    .navigationTitle(type.title)
            case .carouselViewAligned:
                ContentMarginsCarouselViewAlignedPlayground()
                    .navigationTitle(type.title)
            }
        }
    }
}

struct ContentMarginsVStackUniformPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView + VStack with .contentMargins(40)")
                .font(.caption)
                .padding(.horizontal)
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.3))
                            .border(Color.blue, width: 2)
                    }
                }
            }
            .contentMargins(40)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsVStackHorizontalPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView + VStack with .contentMargins(.horizontal, 60)")
                .font(.caption)
                .padding(.horizontal)
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.3))
                            .border(Color.green, width: 2)
                    }
                }
            }
            .contentMargins(.horizontal, 60)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsVStackInsetsPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView + VStack with EdgeInsets(top: 20, leading: 40, bottom: 60, trailing: 80)")
                .font(.caption)
                .padding(.horizontal)
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.3))
                            .border(Color.purple, width: 2)
                    }
                }
            }
            .contentMargins(.all, EdgeInsets(top: 20, leading: 40, bottom: 60, trailing: 80))
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsLazyVStackUniformPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView + LazyVStack with .contentMargins(40)")
                .font(.caption)
                .padding(.horizontal)
            Text("(Critical for Android: Lazy containers bring their own scroll)")
                .font(.caption2)
                .foregroundColor(.secondary)
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<50) { i in
                        Text("Lazy Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.3))
                            .border(Color.orange, width: 2)
                    }
                }
            }
            .contentMargins(40)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsLazyHStackHorizontalPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView(.horizontal) + LazyHStack with .contentMargins(.horizontal, 40)")
                .font(.caption)
                .padding(.horizontal)
            Text("(Critical for Android: Lazy containers bring their own scroll)")
                .font(.caption2)
                .foregroundColor(.secondary)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(0..<30) { i in
                        Text("Item \(i)")
                            .frame(width: 100, height: 100)
                            .background(Color.teal.opacity(0.3))
                            .border(Color.teal, width: 2)
                    }
                }
            }
            .contentMargins(.horizontal, 40)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsListUniformPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("List with .contentMargins(40)")
                .font(.caption)
                .padding(.horizontal)
            Text("(Critical for Android: List has its own scroll container)")
                .font(.caption2)
                .foregroundColor(.secondary)
            List {
                Section("Section 1") {
                    ForEach(0..<15) { i in
                        Text("Row \(i)")
                    }
                }
                Section("Section 2") {
                    ForEach(15..<30) { i in
                        Text("Row \(i)")
                    }
                }
            }
            .contentMargins(40)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsScrollContentPlacementPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView with .contentMargins(40, for: .scrollContent)")
                .font(.caption)
                .padding(.horizontal)
            Text("Content is inset but scroll indicators stay at edges")
                .font(.caption2)
                .foregroundColor(.secondary)
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<30) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.pink.opacity(0.3))
                            .border(Color.pink, width: 2)
                    }
                }
            }
            .contentMargins(40, for: .scrollContent)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct ContentMarginsScrollIndicatorsPlacementPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ScrollView with .contentMargins(40, for: .scrollIndicators)")
                .font(.caption)
                .padding(.horizontal)
            Text("Scroll indicators are inset but content stays at edges")
                .font(.caption2)
                .foregroundColor(.secondary)
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(0..<30) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.indigo.opacity(0.3))
                            .border(Color.indigo, width: 2)
                    }
                }
            }
            .contentMargins(40.0, for: .scrollIndicators)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}

struct CarouselCard: View {
    let color: Color
    let index: Int
    let width: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
            Text("Card \(index + 1)")
                .font(.title)
                .foregroundColor(.white)
                .shadow(radius: 2)
        }
        .frame(width: width, height: 200)
    }
}

struct ContentMarginsCarouselViewAlignedPlayground: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .cyan, .mint, .indigo]

    var body: some View {
        VStack(spacing: 16) {
            Text("Carousel with .contentMargins(.horizontal, 16) + .scrollTargetBehavior(.viewAligned)")
                .font(.caption)
                .padding(.horizontal)
            Text("16pt content margins, 8pt spacing, 8pt peek of next card")
                .font(.caption2)
                .foregroundColor(.secondary)

            GeometryReader { geometry in
                // Calculate card width: fill screen minus content margins, spacing, and peek
                // screenWidth - leftMargin(16) - spacing(8) - peek(8) = cardWidth
                let cardWidth = geometry.size.width - 32

                ScrollView(.horizontal) {
                    LazyHStack(spacing: 8) {
                        ForEach(0..<colors.count, id: \.self) { i in
                            CarouselCard(color: colors[i], index: i, width: cardWidth)
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, 16)
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            }
            .frame(height: 220)
            .border(Color.red, width: 2)
            .padding(.horizontal)
        }
    }
}
