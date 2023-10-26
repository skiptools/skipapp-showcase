// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum ListPlaygroundType: String, CaseIterable {
    case fixedContent
    case indexedContent
    case collectionContent
    case forEachContent
    case sectioned
    case empty
    case plainStyle
    case plainStyleSectioned
    case plainStyleEmpty

    var title: String {
        switch self {
        case .fixedContent:
            return "Fixed Content"
        case .indexedContent:
            return "Indexed Content"
        case .collectionContent:
            return "Collection Content"
        case .forEachContent:
            return "ForEach Content"
        case .sectioned:
            return "Sectioned"
        case .empty:
            return "Empty"
        case .plainStyle:
            return "Plain Style"
        case .plainStyleSectioned:
            return "Plain Style Sectioned"
        case .plainStyleEmpty:
            return "Plain Style Empty"
        }
    }
}

struct ListPlayground: View {
    var body: some View {
        List(ListPlaygroundType.allCases, id: \.rawValue) { type in
            NavigationLink(type.title, value: type)
        }
        .navigationDestination(for: ListPlaygroundType.self) {
            switch $0 {
            case .fixedContent:
                FixedContentListPlayground()
                    .navigationTitle($0.title)
            case .indexedContent:
                IndexedContentListPlayground()
                    .navigationTitle($0.title)
            case .collectionContent:
                CollectionContentListPlayground()
                    .navigationTitle($0.title)
            case .forEachContent:
                ForEachContentListPlayground()
                    .navigationTitle($0.title)
            case .sectioned:
                SectionedListPlayground()
                    .navigationTitle($0.title)
            case .empty:
                EmptyListPlayground()
                    .navigationTitle($0.title)
            case .plainStyle:
                PlainStyleListPlayground()
                    .navigationTitle($0.title)
            case .plainStyleSectioned:
                PlainStyleSectionedListPlayground()
                    .navigationTitle($0.title)
            case .plainStyleEmpty:
                PlainStyleEmptyListPlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

struct FixedContentListPlayground: View {
    var body: some View {
        List {
            Group {
                Text("Row 1")
                Text("Row 2")
            }
            VStack {
                Text("Row 3a")
                Text("Row 3b")
            }
        }
    }
}

struct IndexedContentListPlayground: View {
    var body: some View {
        List(0..<100) {
            Text("Row \($0)")
        }
    }
}

struct CollectionContentListPlayground: View {
    struct ListItem {
        let i: Int
        let s: String
    }

    func items() -> [ListItem] {
        var items: [ListItem] = []
        for i in 0..<100 {
            items.append(ListItem(i: i, s: "Item \(i)"))
        }
        return items
    }

    var body: some View {
        List(items(), id: \.i) {
            Text($0.s)
        }
    }
}

struct ForEachContentListPlayground: View {
    struct ListItem {
        let i: Int
        let s: String
    }

    func items() -> [ListItem] {
        var items: [ListItem] = []
        for i in 0..<10 {
            items.append(ListItem(i: i, s: "Foreach object row \(i)"))
        }
        return items
    }

    var body: some View {
        List {
            Text("Standalone row 1")
            ForEach(0..<10) { index in
                Text("ForEach index row: \(index)")
            }
            Text("Standalone row 2")
            ForEach(items(), id: \.i) {
                Text($0.s)
            }
            Text("Standalone row 3")
            ForEach(0..<10) { index1 in
                ForEach(0..<2) { index2 in
                    Text("Nested ForEach row: \(index1).\(index2)")
                }
            }
        }
    }
}

struct SectionedListPlayground: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Row 1.1")
                ForEach(0..<10) { index in
                    Text("ForEach row: 1.\(index)")
                }
            }
            Section {
                Text("Row 2.1")
                ForEach(0..<10) { index in
                    Text("ForEach row: 2.\(index)")
                }
            } header: {
                Text("Section 2")
            } footer: {
                Text("Footer 2")
            }
            ForEach(0..<2) { index1 in
                Section("ForEach section \(index1)") {
                    ForEach(0..<5) { index2 in
                        Text("ForEach row: \(index1).\(index2)")
                    }
                }
            }
        }
    }
}

struct EmptyListPlayground: View {
    var body: some View {
        List {
        }
    }
}

struct PlainStyleListPlayground: View {
    var body: some View {
        List(0..<100) {
            Text("Row \($0)")
        }
        .listStyle(.plain)
    }
}

struct PlainStyleSectionedListPlayground: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Row 1.1")
                ForEach(0..<30) { index in
                    Text("ForEach row: 1.\(index)")
                }
            }
            Section {
                Text("Row 2.1")
                ForEach(0..<30) { index in
                    Text("ForEach row: 2.\(index)")
                }
            } header: {
                Text("Section 2")
            } footer: {
                Text("Footer 2")
            }
            Section {
                ForEach(0..<30) { index in
                    Text("ForEach row: 3.\(index)")
                }
            } footer: {
                Text("Footer 3")
            }
        }
        .listStyle(.plain)
    }
}

struct PlainStyleEmptyListPlayground: View {
    var body: some View {
        List {
        }
        .listStyle(.plain)
    }
}
