// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum TablePlaygroundType: String, CaseIterable {
    case evenColumns

    var title: String {
        switch self {
        case .evenColumns:
            return "Even Columns"
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
            case .evenColumns:
                EvenColumnsTablePlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

private struct TableData: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
}

private struct EvenColumnsTablePlayground: View {
    @State var data = Self.initialData

    var body: some View {
        #if !SKIP
        Table(data) {
            TableColumn("Name", value: \.name)
            TableColumn("Value") { data in
                Text("\(data.value)")
            }
        }
        #else
        EmptyView()
        #endif
    }

    static var initialData: [TableData] {
        return (1...20).map { TableData(name: "Item \($0)", value: $0) }
    }
}

