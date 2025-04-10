// Copyright 2023–2025 Skip
import SwiftUI

struct StackPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Before fixed")
                        .border(Color.blue)
                    HStack {
                        Spacer()
                        Text("After expanding")
                    }
                    .border(Color.red)
                    Text("After fixed")
                        .border(Color.blue)
                }
                VStack {
                    Text("Text1 gy")
                    Text("Text2 TA")
                }
                .border(Color.blue)
                Text("Sized to content:").bold()
                VStack(spacing: 0) {
                    Color.red.frame(width: 50, height: 50)
                    Color.green.frame(width: 50, height: 50)
                }
                .border(Color.blue)
                Text("Content sizes to stack:").bold()
                VStack(spacing: 0) {
                    Color.red
                    Color.green
                }
                .frame(width: 50, height: 100)
                .border(Color.blue)
                VStack {
                    Text("Text1")
                    Color.green.frame(width: 50, height: 50)
                }
                .border(Color.blue)
                VStack {
                    Color.red.frame(width: 50, height: 50)
                    Text("Text2")
                }
                .border(Color.blue)
                VStack(content: horizontalStripes)
                    .background(.yellow)
                    .frame(width: 100, height: 100)
                HStack(content: verticalStripes)
                    .background(.yellow)
                    .frame(width: 100, height: 100)
                ZStack {
                    Color.yellow
                    Color.red.padding(25)
                }
                .frame(width: 100, height: 100)
                Text("ForEach:").bold()
                HStack {
                    ForEach(words, id: \.self) { word in
                        Text(word).border(.blue)
                    }
                }
                HStack {
                    ForEach(images, id: \.self) { image in
                        Image(systemName: image)
                    }
                }
                Text("LazyHStack").bold()
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<20) { i in
                            ZStack {
                                Color.yellow
                                Text(String(describing: i))
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                }
                NavigationLink {
                    LazyVStackScrollView(count: 50)
                        .navigationTitle("LazyVStack")
                } label: {
                    Text("LazyVStack").bold()
                }
                NavigationLink {
                    LazyVStackScrollView(count: 5)
                        .navigationTitle("LazyVStack")
                } label: {
                    Text("LazyVStack (fewer items)").bold()
                }
                NavigationLink {
                    ScrollViewStacksView()
                        .navigationTitle("Scroll View Stacks")
                } label: {
                    Text("Scroll View Stacks").bold()
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "StackPlayground.swift")
        }
    }

    private let words = ["The", "quick", "brown", "fox"]
    private let images = ["wrench", "phone", "pencil", "calendar"]

    // Note: these functions are also a test that we can pass functions to SwiftUI content view builders.

    @ViewBuilder private func horizontalStripes() -> some View {
        Spacer()
        Color.red.frame(height: 20)
        Spacer()
        Color.red.frame(height: 20)
        Spacer()
    }

    @ViewBuilder private func verticalStripes() -> some View {
        Spacer()
        Color.red.frame(width: 20)
        Spacer()
        Color.red.frame(width: 20)
        Spacer()
    }
}

private struct LazyVStackScrollView: View {
    let count: Int

    var body: some View {
        ScrollView {
            // Test that we can nest the LazyVStack in a custom view within the parent ScrollView
            LazyVStackView(count: count)
                .border(.blue, width: 5)
        }
    }
}

private struct LazyVStackView: View {
    let count: Int

    var body: some View {
        LazyVStack {
            ForEach(0..<count, id: \.self) { index in
                ZStack {
                    Color.yellow
                    Text(String(describing: index))
                }
                .frame(width: 40, height: 40)
            }
        }
    }
}

private struct ScrollViewStacksView: View {
    var body: some View {
        ScrollView(.vertical) {
          ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 8.0) {
              VStack {
                VStack {
                  Text("Test 1")

                  Spacer()

                  Text("Test 2")
                }
                .border(.blue)
              }
              .frame(width: 150.0)
              .border(.red)

              VStack {
                VStack {
                  Text("Test A\nTest B\nTest C\nTest D\nTest E")
                }
                .border(.blue)
              }
              .frame(width: 150.0)
              .border(.red)
            }
          }
          .border(.black)
        }
    }
}
