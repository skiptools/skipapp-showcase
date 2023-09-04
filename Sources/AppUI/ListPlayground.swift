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
                .padding()
            NavigationLink("Indexed Content", value: ListPlaygroundType.indexedContent)
                .padding()
            NavigationLink("Collection Content", value: ListPlaygroundType.collectionContent)
                .padding()
        }
    }
}

struct FixedContentListPlayground: View {
    var body: some View {
        List {
            Group {
                Text("Row 1").padding()
                Text("Row 2").padding()
            }
            VStack {
                Text("Row 3a").padding()
                Text("Row 3b").padding()
            }
        }
    }
}

struct IndexedContentListPlayground: View {
    var body: some View {
        List(0..<100) {
            Text("Row \($0)").padding()
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
            Text($0.s).padding()
        }
    }
}
