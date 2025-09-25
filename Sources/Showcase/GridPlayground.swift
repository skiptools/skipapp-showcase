// Copyright 2023–2025 Skip
import SwiftUI

struct GridPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                NavigationLink("LazyVGrid .adaptive") {
                    LazyVGridAdaptiveView(count: 100)
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
                NavigationLink("LazyVGrid (fewer items)") {
                    LazyVGridAdaptiveView(count: 5)
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyHGrid .adaptive") {
                    LazyHGridAdaptiveView(count: 100)
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
                NavigationLink("LazyVGrid .padding") {
                    LazyVGridPaddingView()
                        .navigationTitle("LazyVGridView")
                }
                NavigationLink("LazyHGrid (fewer items)") {
                    LazyHGridAdaptiveView(count: 5)
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

struct LazyVGridAdaptiveView: View {
    let count: Int

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                VGridCellsView(start: 0, count: count, color: .yellow)
            }
        }
    }
}

struct LazyVGridFlexibleView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0..<50) { index in
                    VGridCell(index: index, color: .yellow)
                    VGridCell(index: index, color: .green)
                }
            }
        }
    }
}

struct LazyVGridFixedView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]) {
                ForEach(0..<25) { index in
                    VGridCell(index: index, color: .yellow)
                    VGridCell(index: index, color: .green)
                    VGridCell(index: index, color: .pink)
                    VGridCell(index: index, color: .orange)
                }
            }
        }
    }
}

struct LazyVGridTrailingView: View {
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

struct LazyVGridSectionedView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<5) { index in
                    Section {
                        VGridCellsView(start: index * 100, count: 10, color: .yellow)
                    } header: {
                        Text("Section \(index) Header")
                    } footer: {
                        Text("Section footer")
                    }
                    .border(.orange)
                }
            }
        }
    }
}

struct LazyVGridRefreshableView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                VGridCellsView(start: 0, count: 100, color: .yellow)
            }
        }
        .refreshable {
            do { try await Task.sleep(nanoseconds: 3_000_000_000) } catch { }
        }
    }
}

struct LazyHGridAdaptiveView: View {
    let count: Int

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))]) {
                HGridCellsView(start: 0, count: count, color: .yellow)
            }
        }
    }
}

struct LazyHGridFlexibleView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0..<50) { index in
                    HGridCell(index: index, color: .yellow)
                    HGridCell(index: index, color: .green)
                }
            }
        }
    }
}

struct LazyHGridFixedView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]) {
                ForEach(0..<25) { index in
                    HGridCell(index: index, color: .yellow)
                    HGridCell(index: index, color: .green)
                    HGridCell(index: index, color: .pink)
                    HGridCell(index: index, color: .orange)
                }
            }
            .frame(height: 400)
        }
    }
}

struct LazyHGridBottomView: View {
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

struct LazyHGridSectionedView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<5) { index in
                    Section {
                        HGridCellsView(start: index * 100, count: 10, color: .yellow)
                    } header: {
                        Text("Section \(index) Header")
                    } footer: {
                        Text("Section footer")
                    }
                    .border(.orange)
                }
            }
        }
    }
}

struct LazyVGridPaddingView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                VGridCellsView(start: 0, count: 100, color: .yellow)
            }
            .padding(32)
        }
    }
}

struct VGridCellsView: View {
    let start: Int
    let count: Int
    let color: Color

    var body: some View {
        ForEach(start..<(start + count), id: \.self) { index in
            VGridCell(index: index, color: color)
        }
    }
}

struct HGridCellsView: View {
    let start: Int
    let count: Int
    let color: Color

    var body: some View {
        ForEach(start..<(start + count), id: \.self) { index in
            HGridCell(index: index, color: color)
        }
    }
}

struct VGridCell: View {
    let index: Int
    let color: Color

    var body: some View {
        ZStack {
            color
            Text(String(describing: index))
        }
        .frame(height: 80)
    }
}

struct HGridCell: View {
    let index: Int
    let color: Color

    var body: some View {
        ZStack {
            color
            Text(String(describing: index))
        }
        .frame(width: 80)
    }
}
