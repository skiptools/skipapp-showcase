// Copyright 2023–2025 Skip
import SwiftUI


enum TablePlaygroundType: String, CaseIterable {
    case defaultColumns
    case fixedWidthColumns
    case rangeWidthColumns
    case selection
    case selectionSet

    var title: LocalizedStringResource {
        switch self {
        case .defaultColumns:
            return LocalizedStringResource("Default Columns")
        case .fixedWidthColumns:
            return LocalizedStringResource("Fixed Width Columns")
        case .rangeWidthColumns:
            return LocalizedStringResource("Range Width Columns")
        case .selection:
            return LocalizedStringResource("Selection")
        case .selectionSet:
            return LocalizedStringResource("Selection Set")
        }
    }
}

#if !os(iOS) || !SKIP // Skip Lite only
struct TablePlayground: View {
    var body: some View {
        Text("Table not yet supported in Skip Fuse")
    }
}
#else
struct TablePlayground: View {
    var body: some View {
        List(TablePlaygroundType.allCases, id: \.self) { type in
            NavigationLink(value: type) { Text(type.title) }
        }
        .toolbar {
            PlaygroundSourceLink(file: "TablePlayground.swift")
        }
        .navigationDestination(for: TablePlaygroundType.self) {
            switch $0 {
            case .defaultColumns:
                DefaultColumnsTablePlayground()
                    .navigationTitle(Text($0.title))
            case .fixedWidthColumns:
                FixedWidthColumnsTablePlayground()
                    .navigationTitle(Text($0.title))
            case .rangeWidthColumns:
                RangeWidthColumnsTablePlayground()
                    .navigationTitle(Text($0.title))
            case .selection:
                SelectionTablePlayground()
                    .navigationTitle(Text($0.title))
            case .selectionSet:
                SelectionSetTablePlayground()
                    .navigationTitle(Text($0.title))
            }
        }
    }
}

struct TableData: Identifiable {
    let id = UUID()
    let name: String
    let value: Int

    static var initialData: [TableData] {
        return (1...20).map { TableData(name: "Item \($0)", value: $0) }
    }
}

struct DefaultColumnsTablePlayground: View {
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

struct FixedWidthColumnsTablePlayground: View {
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

struct RangeWidthColumnsTablePlayground: View {
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

struct SelectionTablePlayground: View {
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

struct SelectionSetTablePlayground: View {
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
#endif
