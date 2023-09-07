// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ListPlayground: View {
    var body: some View {
        List {
            NavigationLink("Fixed Content", value: ListPlaygroundType.fixedContent)
            NavigationLink("Indexed Content", value: ListPlaygroundType.indexedContent)
            NavigationLink("Collection Content", value: ListPlaygroundType.collectionContent)
            NavigationLink("Plain Style", value: ListPlaygroundType.plainStyle)
            NavigationLink("Controls", value: ListPlaygroundType.controls)
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
    }
}
