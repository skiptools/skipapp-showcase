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
    case plainStyle
    case controls

    var title: String {
        switch self {
        case .fixedContent:
            return "Fixed Content"
        case .indexedContent:
            return "Indexed Content"
        case .collectionContent:
            return "Collection Content"
        case .plainStyle:
            return "Plain Style"
        case .controls:
            return "Controls"
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
            case .plainStyle:
                PlainStyleListPlayground()
                    .navigationTitle($0.title)
            case .controls:
                ControlsListPlayground()
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

struct PlainStyleListPlayground: View {
    var body: some View {
        List(0..<100) {
            Text("Row \($0)")
        }
        .listStyle(.plain)
    }
}

struct ControlsListPlayground: View {
    @State var toggleValue = false

    var body: some View {
        List {
            Label("Label", systemImage: "star.fill")
            Label("Label .font(.title)", systemImage: "star.fill")
                .font(.title)
            Label("Label .foregroundStyle(Color.red)", systemImage: "star.fill")
                .foregroundStyle(Color.red)
            Label("Label .tint(.red)", systemImage: "star.fill")
                .tint(.red)
            Label("Label .listItemTint(.red)", systemImage: "star.fill")
                .listItemTint(.red)
            NavigationLink(value: "Test") {
                Label("Label in NavigationLink", systemImage: "star.fill")
            }
            Button("Button .automatic", action: { logger.info("Tap") })
            Button("Button .bordered", action: { logger.info("Tap") })
                .buttonStyle(.bordered)
            Button(action: { logger.info("Tap") }) {
                HStack {
                    Text("Complex content button")
                    Spacer()
                    Button("Inner button", action: { logger.info("Tap inner") })
                }
            }
            Toggle(isOn: $toggleValue) {
                Text("Toggle")
            }
        }
        .navigationDestination(for: String.self) { value in
            Text(value)
        }
    }
}
