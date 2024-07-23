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
    case emptyItems
    case plainStyle
    case plainStyleSectioned
    case plainStyleEmpty
    case refreshable
    case hiddenBackground
    case hiddenBackgroundPlainStyle
    case editActions
    case observableEditActions
    case sectionedEditActions
    case plainStyleSectionedEditActions
    case onMoveDelete

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
        case .emptyItems:
            return "Empty Items"
        case .plainStyle:
            return "Plain Style"
        case .plainStyleSectioned:
            return "Plain Style Sectioned"
        case .plainStyleEmpty:
            return "Plain Style Empty"
        case .refreshable:
            return "Refreshable"
        case .hiddenBackground:
            return "Hidden Background"
        case .hiddenBackgroundPlainStyle:
            return "Hidden Background Plain Style"
        case .editActions:
            return "EditActions"
        case .observableEditActions:
            return "Observable Plain Style EditActions"
        case .sectionedEditActions:
            return "Sectioned EditActions"
        case .plainStyleSectionedEditActions:
            return "Plain Style Sectioned EditActions"
        case .onMoveDelete:
            return ".onMove, .onDelete"
        }
    }
}

struct ListPlayground: View {
    @StateObject var editActionsModel = ObservableEditActionsListPlayground.Model()

    var body: some View {
        List(ListPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "ListPlayground.swift")
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
            case .emptyItems:
                EmptyItemsListPlayground()
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
            case .refreshable:
                RefreshableListPlayground()
                    .navigationTitle($0.title)
            case .hiddenBackground:
                HiddenBackgroundListPlayground()
                    .navigationTitle($0.title)
            case .hiddenBackgroundPlainStyle:
                HiddenBackgroundPlainStyleListPlayground()
                    .navigationTitle($0.title)
            case .editActions:
                EditActionsListPlayground()
                    .navigationTitle($0.title)
            case .observableEditActions:
                ObservableEditActionsListPlayground(model: editActionsModel)
                    .navigationTitle($0.title)
            case .sectionedEditActions:
                SectionedEditActionsListPlayground()
                    .navigationTitle($0.title)
            case .plainStyleSectionedEditActions:
                PlainStyleSectionedEditActionsListPlayground()
                    .navigationTitle($0.title)
            case .onMoveDelete:
                OnMoveDeleteListPlayground()
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
        List(100..<200) {
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
        let id: UUID // Test ID serialization
        let i: Int
        let s: String
    }

    func items() -> [ListItem] {
        var items: [ListItem] = []
        for i in 0..<10 {
            items.append(ListItem(id: UUID(), i: i, s: "Foreach object row \(i)"))
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
            ForEach(items(), id: \.id) {
                Text($0.s)
            }
            Text("Standalone row 3")
            ForEach(0..<10) { index1 in
                ForEach(1..<3) { index2 in
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

struct EmptyItemsListPlayground: View {
    var body: some View {
        List {
            EmptyView()
            Text("After initial empty row")
            Section("Section 1") {
                EmptyView()
                Text("After initial section empty row")
                EmptyView()
                Text("After another section empty row")
            }
            Section("Section 2") {
                Text("Before final section empty row")
                EmptyView()
            }
            Text("Before final empty row")
            EmptyView()
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

struct RefreshableListPlayground: View {
    class Model: ObservableObject {
        @Published var items: [Int] = {
            var items: [Int] = []
            for i in 0..<50 {
                items.append(i)
            }
            return items
        }()
    }

    @StateObject var model = Model()

    var body: some View {
        List(model.items, id: \.self) { item in
            Text(verbatim: "Item \(item)")
        }
        .refreshable {
            do { try await Task.sleep(nanoseconds: 3_000_000_000) } catch { }
            let min = model.items[0]
            model.items.insert(min - 1, at: 0)
        }
    }
}

struct HiddenBackgroundListPlayground: View {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.5)
            List {
                Section("Standard Row Background") {
                    ForEach(0..<30) { index in
                        Text("Row: 1.\(index)")
                    }
                }
                Section {
                    ForEach(0..<30) { index in
                        Text("Row: 2.\(index)")
                            .listRowBackground(Color.pink)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Pink Row Background")
                } footer: {
                    Text("... and hidden separators")
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct HiddenBackgroundPlainStyleListPlayground: View {
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.5)
            List {
                Section("Section 1") {
                    ForEach(0..<30) { index in
                        Text("Row: 1.\(index)")
                    }
                }
                Section {
                    ForEach(0..<30) { index in
                        Text("Row: 2.\(index)")
                            .listRowBackground(Color.pink)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    Text("Section 2")
                } footer: {
                    Text("Footer")
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

struct EditActionsListPlayground: View {
    struct ListItem {
        let i: Int
        let s: String
        var toggled = false
    }

    @State var items = {
        var items: [ListItem] = []
        for i in 0..<50 {
            items.append(ListItem(i: i, s: "Item \(i)"))
        }
        return items
    }()

    var body: some View {
        List($items, id: \.i, editActions: .all) { $item in
            if item.i % 5 == 0 {
                Text("\(item.s) .deleteDisabled")
                    .deleteDisabled(true)
            } else if item.i % 4 == 0 {
                Text("\(item.s) .moveDisabled")
                    .moveDisabled(true)
            } else {
                HStack {
                    Text(item.s)
                    Spacer()
                    Toggle("isOn", isOn: $item.toggled)
                        .labelsHidden()
                }
            }
        }
    }
}

struct ObservableEditActionsListPlayground: View {
    class Model: ObservableObject {
        @Published var items: [ListItem] = {
            var items: [ListItem] = []
            for i in 0..<50 {
                items.append(ListItem(i: i, s: "Item \(i)"))
            }
            return items
        }()
    }
    struct ListItem {
        let i: Int
        let s: String
        var toggled = false
    }

    @ObservedObject var model: Model

    var body: some View {
        List($model.items, id: \.i, editActions: .all) { $item in
            HStack {
                Text(item.s)
                Spacer()
                Toggle("isOn", isOn: $item.toggled)
                    .labelsHidden()
            }
        }
        .listStyle(.plain)
    }
}

struct SectionedEditActionsListPlayground: View {
    @State var items0 = {
        var items: [Int] = []
        for i in 0..<10 {
            items.append(i)
        }
        return items
    }()
    @State var items1 = {
        var items: [Int] = []
        for i in 11..<20 {
            items.append(i)
        }
        return items
    }()
    @State var items2 = {
        var items: [Int] = []
        for i in 21..<30 {
            items.append(i)
        }
        return items
    }()

    var body: some View {
        List {
            Section("Section 0 (Fixed)") {
                ForEach(items0, id: \.self) { item in
                    Text("Item \(item)")
                }
            }
            Section("Section 1") {
                ForEach($items1, id: \.self, editActions: .all) { $item in
                    Text("Item \(item)")
                }
            }
            Section("Section 2") {
                ForEach($items2, id: \.self, editActions: .all) { $item in
                    Text("Item \(item)")
                }
            }
        }
    }
}

struct PlainStyleSectionedEditActionsListPlayground: View {
    @State var items0 = {
        var items: [Int] = []
        for i in 0..<10 {
            items.append(i)
        }
        return items
    }()
    @State var items1 = {
        var items: [Int] = []
        for i in 11..<20 {
            items.append(i)
        }
        return items
    }()
    @State var items2 = {
        var items: [Int] = []
        for i in 21..<30 {
            items.append(i)
        }
        return items
    }()

    var body: some View {
        List {
            Section("Section 0 (Fixed)") {
                ForEach(items0, id: \.self) { item in
                    Text("Item \(item)")
                }
            }
            Section("Section 1") {
                ForEach($items1, id: \.self, editActions: .all) { $item in
                    Text("Item \(item)")
                }
            }
            Section("Section 2") {
                ForEach($items2, id: \.self, editActions: .all) { $item in
                    Text("Item \(item)")
                }
            }
        }
        .listStyle(.plain)
    }
}

struct OnMoveDeleteListPlayground: View {
    @State var items0 = {
        var items: [Int] = []
        for i in 0..<10 {
            items.append(i)
        }
        return items
    }()
    @State var items1 = {
        var items: [Int] = []
        for i in 11..<20 {
            items.append(i)
        }
        return items
    }()
    @State var items2 = {
        var items: [Int] = []
        for i in 21..<30 {
            items.append(i)
        }
        return items
    }()

    @State var actionString = ""
    @State var action: () -> Void = {}
    @State var actionIsPresented = false

    var body: some View {
        List {
            Section(".onMove") {
                ForEach(items0, id: \.self) { item in
                    Text("Item \(item)")
                }
                .onMove { fromOffsets, toOffset in
                    actionString = "Move \(fromOffsets.count) item(s)"
                    action = {
                        withAnimation { items0.move(fromOffsets: fromOffsets, toOffset: toOffset) }
                        action = {}
                    }
                    actionIsPresented = true
                }
            }
            Section(".onDelete") {
                ForEach(items1, id: \.self) { item in
                    Text("Item \(item)")
                }
                .onDelete { offsets in
                    actionString = "Delete \(offsets.count) item(s)"
                    action = {
                        withAnimation { items1.remove(atOffsets: offsets) }
                        action = {}
                    }
                    actionIsPresented = true
                }
            }
            Section(".onMove, .onDelete") {
                ForEach(items2, id: \.self) { item in
                    Text("Item \(item)")
                }
                .onMove { fromOffsets, toOffset in
                    actionString = "Move \(fromOffsets.count) item(s)"
                    action = {
                        withAnimation { items2.move(fromOffsets: fromOffsets, toOffset: toOffset) }
                        action = {}
                    }
                    actionIsPresented = true
                }
                .onDelete { offsets in
                    actionString = "Delete \(offsets.count) item(s)"
                    action = {
                        withAnimation { items2.remove(atOffsets: offsets) }
                        action = {}
                    }
                    actionIsPresented = true
                }
            }
        }
        .confirmationDialog(actionString, isPresented: $actionIsPresented) {
            Button(actionString, role: .destructive, action: action)
        }
    }
}
