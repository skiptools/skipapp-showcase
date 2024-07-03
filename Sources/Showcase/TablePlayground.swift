// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum TablePlaygroundType: String, CaseIterable {
    case defaultColumns
    case fixedWidthColumns
    case rangeWidthColumns
    case selection
    case selectionSet

    var title: String {
        switch self {
        case .defaultColumns:
            return "Default Columns"
        case .fixedWidthColumns:
            return "Fixed Width Columns"
        case .rangeWidthColumns:
            return "Range Width Columns"
        case .selection:
            return "Selection"
        case .selectionSet:
            return "Selection Set"
        }
    }
}

struct TablePlayground: View {
    var body: some View {
        List(TablePlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .toolbar {
            PlaygroundSourceLink(file: "TablePlayground.swift")
        }
        .navigationDestination(for: TablePlaygroundType.self) {
            switch $0 {
            case .defaultColumns:
                DefaultColumnsTablePlayground()
                    .navigationTitle($0.title)
            case .fixedWidthColumns:
                FixedWidthColumnsTablePlayground()
                    .navigationTitle($0.title)
            case .rangeWidthColumns:
                RangeWidthColumnsTablePlayground()
                    .navigationTitle($0.title)
            case .selection:
                SelectionTablePlayground()
                    .navigationTitle($0.title)
            case .selectionSet:
                SelectionSetTablePlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

private struct TableData: Identifiable {
    let id = UUID()
    let name: String
    let value: Int

    static var initialData: [TableData] {
        return (1...20).map { TableData(name: "Item \($0)", value: $0) }
    }
}

private struct DefaultColumnsTablePlayground: View {
    @State var data = TableData.initialData

    var body: some View {
        Table(data) {
            TableColumn("UUID", content: { data in
                // SKIP NOWARN
                Text(String(data.id.uuidString.prefix(8)))
            })
            TableColumn("Name", value: \.name)
            TableColumn("Value", content: { data in
                Text("\(data.value)")
            })
        }
    }
}

private struct FixedWidthColumnsTablePlayground: View {
    @State var data = TableData.initialData

    var body: some View {
        Table(data) {
            TableColumn("UUID", content: { data in
                // SKIP NOWARN
                Text(String(data.id.uuidString.prefix(8)))
            })
            .width(100)
            TableColumn("Name", value: \.name)
                .width(100)
            TableColumn("Value", content: { data in
                Text("\(data.value)")
            })
        }
    }
}

private struct RangeWidthColumnsTablePlayground: View {
    @State var data = TableData.initialData

    var body: some View {
        Table(data) {
            TableColumn("UUID", content: { data in
                // SKIP NOWARN
                Text(String(data.id.uuidString.prefix(8)))
            })
            .width(min: 100, max: 200)
            TableColumn("Name", value: \.name)
                .width(ideal: 100)
            TableColumn("Value", content: { data in
                Text("\(data.value)")
            })
        }
    }
}

private struct SelectionTablePlayground: View {
    @State var data = TableData.initialData
    @State var selection: UUID?

    var body: some View {
        Table(data, selection: $selection) {
            TableColumn("UUID", content: { data in
                // SKIP NOWARN
                Text(String(data.id.uuidString.prefix(8)))
            })
            TableColumn("Name", value: \.name)
            TableColumn("Value", content: { data in
                Text("\(data.value)")
            })
        }
    }
}

private struct SelectionSetTablePlayground: View {
    @State var data = TableData.initialData
    @State var selection: Set<UUID> = []

    var body: some View {
        Table(data, selection: $selection) {
            TableColumn("UUID", content: { data in
                // SKIP NOWARN
                Text(String(data.id.uuidString.prefix(8)))
            })
            TableColumn("Name", value: \.name)
            TableColumn("Value", content: { data in
                Text("\(data.value)")
            })
        }
    }
}
