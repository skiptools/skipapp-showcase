// Copyright 2023–2025 Skip
import SwiftUI
import SkipSQL

struct SQLPlayground: View {
    /// The shared global SQL context for the whole app
    static let context = try! openDatabase()
    @State var items: [SQLItem] = []

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(value: item) {
                    VStack(alignment: .leading) {
                        if item.name.isEmpty {
                            Text("Untitled Item")
                                .foregroundStyle(.secondary)
                        } else {
                            Text(item.name)
                        }
                        Text(item.date.formatted())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete { indices in
                try! deleteItems(from: indices)
            }

            Section {
                NavigationLink(value: SQLItem(name: "", date: Date())) {
                    Text("New Item")
                }
            }
        }
        .onAppear {
            try! reloadItems()
        }
        .navigationDestination(for: SQLItem.self) { item in
            SQLPlaygroundItemEditorView(item: item)
        }
        .toolbar {
            PlaygroundSourceLink(file: "SQLPlayground.swift")
        }
    }

    func reloadItems() throws {
        items = try loadItems()
    }

    func loadItems() throws -> [SQLItem] {
        try Self.context.query(SQLItem.self)
            .orderBy(SQLItem.date, order: .descending)
            .orderBy(SQLItem.id, order: .ascending)
            .eval().load()
    }

    func deleteItems(from fromIndices: IndexSet) throws {
        try Self.context.delete(instances: fromIndices.map({ items[$0] }))
        try reloadItems()
    }

    /// Loads the app's `database.sqlite`, creating it and initializing the schema if it does not exist
    private static func openDatabase() throws -> SQLContext {
        let dir = URL.applicationSupportDirectory
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let ctx = try SQLContext(path: dir.appendingPathComponent("db.sqlite").path, flags: [.create, .readWrite])

        ctx.trace { sql in
            logger.info("SQLPlayground: \(sql)")
        }

        // schema creation and migration is tracked by the database's userVersion
        if ctx.userVersion < 1 {
            for ddl in SQLItem.table.createTableSQL() {
                try ctx.exec(ddl)
            }
            ctx.userVersion = 1
        }

        if ctx.userVersion < 2 {
            // future schema additions or migrations…
            //ctx.userVersion = 2
        }

        return ctx
    }
}

struct SQLPlaygroundItemEditorView: View {
    @State var item: SQLItem
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            TextField("Name", text: $item.name)
            DatePicker("Date", selection: $item.date)
        }
        .toolbar {
            Button("Save") {
                try! SQLPlayground.context.insert(item, upsert: true) // insert or update the item
                dismiss() // pop back up
            }
        }
    }
}

/// A type that can read and write its values to the `SQL_ITEM` table.
public struct SQLItem: Identifiable, Hashable, SQLCodable {
    public var id: Int64
    static let id = SQLColumn(name: "ID", type: .long, primaryKey: true, autoincrement: true)

    public var name: String
    static let name = SQLColumn(name: "NAME", type: .text, index: SQLIndex(name: "IDX_NAME"))

    public var date: Date
    static let date = SQLColumn(name: "DATE", type: .real)

    public static let table = SQLTable(name: "SQL_ITEM", columns: [id, name, date])

    public init(id: Int64 = 0, name: String, date: Date) {
        self.id = id
        self.name = name
        self.date = date
    }

    /// Required initializer to create an instance from the given `SQLRow = [SQLColumn: SQLValue]`
    public init(row: SQLRow, context: SQLContext) throws {
        self.id = try Self.id.longValueRequired(in: row)
        self.name = try Self.name.textValueRequired(in: row)
        self.date = try Self.date.dateValueRequired(in: row)
    }

    /// Encode the current instance into the given `SQLRow` dictionary.
    public func encode(row: inout SQLRow) throws {
        row[Self.id] = SQLValue(self.id)
        row[Self.name] = SQLValue(self.name)
        row[Self.date] = SQLValue(self.date.timeIntervalSince1970)
    }
}
