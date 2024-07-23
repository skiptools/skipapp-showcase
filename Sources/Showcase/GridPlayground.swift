// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GridPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                NavigationLink("LazyVGrid .adaptive") {
                    LazyVGridAdaptiveView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyVGrid .flexible") {
                    LazyVGridFlexibleView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyVGrid .fixed") {
                    LazyVGridFixedView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyVGrid .trailing") {
                    LazyVGridTrailingView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyVGrid sectioned") {
                    LazyVGridSectionedView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyVGrid refreshable") {
                    LazyVGridRefreshableView()
                        .navigationTitle("Refreshable")
                }
                NavigationLink("LazyHGrid .adaptive") {
                    LazyHGridAdaptiveView()
                        .navigationTitle("LazyHGridView")
                }
                NavigationLink("LazyHGrid .flexible") {
                    LazyHGridFlexibleView()
                        .navigationTitle("LazyHGridView")
                }
                NavigationLink("LazyHGrid .fixed") {
                    LazyHGridFixedView()
                        .navigationTitle("LazyHGridView")
                }
                NavigationLink("LazyHGrid .bottom") {
                    LazyHGridBottomView()
                        .navigationTitle("LazyHGridView")
                }
                NavigationLink("LazyHGrid sectioned") {
                    LazyHGridSectionedView()
                        .navigationTitle("LazyHGridView")
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GridPlayground.swift")
        }
    }
}

private struct LazyVGridAdaptiveView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                }
            }
        }
    }
}

private struct LazyVGridFlexibleView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0..<50) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                    ZStack {
                        Color.green
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                }
            }
        }
    }
}

private struct LazyVGridFixedView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]) {
                ForEach(0..<25) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                    ZStack {
                        Color.green
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                    ZStack {
                        Color.pink
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                    ZStack {
                        Color.orange
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                }
            }
        }
    }
}

private struct LazyVGridTrailingView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), alignment: .trailing)]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(width: 40, height: 40)
                }
            }
        }
    }
}

private struct LazyVGridSectionedView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<5) { index in
                    Section {
                        ForEach(0..<10) { index in
                            ZStack {
                                Color.yellow
                                Text(String(describing: index))
                            }
                            .frame(height: 80)
                        }
                    } header: {
                        Text("Section \(index) Header")
                    } footer: {
                        Text("Section footer")
                    }
                }
            }
        }
    }
}

private struct LazyVGridRefreshableView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                }
            }
        }
        .refreshable {
            do { try await Task.sleep(nanoseconds: 3_000_000_000) } catch { }
        }
    }
}

private struct LazyHGridAdaptiveView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                }
            }
        }
    }
}

private struct LazyHGridFlexibleView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0..<50) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                    ZStack {
                        Color.green
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                }
            }
        }
    }
}

private struct LazyHGridFixedView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]) {
                ForEach(0..<25) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                    ZStack {
                        Color.green
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                    ZStack {
                        Color.pink
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                    ZStack {
                        Color.orange
                        Text(String(describing: index))
                    }
                    .frame(width: 80)
                }
            }
            .frame(height: 400)
        }
    }
}

private struct LazyHGridBottomView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80), alignment: .bottom)]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(width: 40, height: 40)
                }
            }
        }
    }
}

private struct LazyHGridSectionedView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<5) { index in
                    Section {
                        ForEach(0..<10) { index in
                            ZStack {
                                Color.yellow
                                Text(String(describing: index))
                            }
                            .frame(width: 80)
                        }
                    } header: {
                        Text("Section \(index) Header")
                    } footer: {
                        Text("Section footer")
                    }
                }
            }
        }
    }
}
