// Copyright 2023–2025 Skip
import SwiftUI
import SkipSQL

struct SQLPlayground: View {
    /// The shared SQL context for the view hierarchy
    @State var database = try! SQLDatabase(name: "database.sqlite")

    var body: some View {
        SQLItemListView()
            .environment(database)
            .toolbar {
                PlaygroundSourceLink(file: "SQLPlayground.swift")
            }
    }
}

/// A list of `SQLItem` instances with create/read/update/delete capabilities
struct SQLItemListView: View {
    @Environment(SQLDatabase.self) var database

    var body: some View {
        List {
            Section {
                ForEach(database.items) { item in
                    NavigationLink(value: item) {
                        VStack(alignment: .leading) {
                            if item.name.isEmpty {
                                Text("New Item")
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
                    database.deleteItems(atOffsets: Array(indices))
                }
                .onMove { from, to in
                    database.moveItems(fromOffsets: Array(from), toOffset: to)
                }
            } footer: {
                NavigationLink {
                    TextEditor(text: .constant(database.statements.joined(separator: "\n")))
                        .font(Font.body.monospaced())
                        .navigationTitle("SQL Log")
                } label: {
                    Text(database.lastActionSQL ?? "SQL Log")
                        .font(Font.caption.monospaced())
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                }
            }
        }
        .navigationDestination(for: SQLItem.self) { item in
            SQLItemEditorView(item: item)
                .environment(database)
        }
        .toolbar {
            ToolbarItem {
                Button {
                    withAnimation {
                        database.createItem()
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    }
}

/// An editor for a `SQLItem`
struct SQLItemEditorView: View {
    @State var item: SQLItem
    @Environment(SQLDatabase.self) var database
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            TextField("Name", text: $item.name)
            DatePicker("Date", selection: $item.date)
        }
        .toolbar {
            Button("Save") {
                database.updateItem(item)
                dismiss() // pop back up on save
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

    public var sortOrder: Double?
    static let sortOrder = SQLColumn(name: "SORT_ORDER", type: .real, index: SQLIndex(name: "IDX_SORT"))

    public static let table = SQLTable(name: "SQL_ITEM", columns: [id, name, date, sortOrder])

    public init(id: Int64 = 0, name: String, date: Date, sortOrder: Double? = nil) {
        self.id = id
        self.name = name
        self.date = date
        self.sortOrder = sortOrder
    }

    /// Required initializer to create an instance from the given `SQLRow = [SQLColumn: SQLValue]`
    public init(row: SQLRow, context: SQLContext) throws {
        self.id = try Self.id.longValueRequired(in: row)
        self.name = try Self.name.textValueRequired(in: row)
        self.date = try Self.date.dateValueRequired(in: row)
        self.sortOrder = Self.sortOrder.realValue(in: row)
    }

    /// Encode the current instance into the given `SQLRow` dictionary.
    public func encode(row: inout SQLRow) throws {
        row[Self.id] = SQLValue(self.id)
        row[Self.name] = SQLValue(self.name)
        row[Self.date] = SQLValue(self.date.timeIntervalSince1970)
        row[Self.sortOrder] = SQLValue(self.sortOrder)
    }
}

/// The database for the view hierarchy, which holds a `SQLContext`
@Observable public class SQLDatabase {
    /// The internal SQLContext that manages the database
    private let context: SQLContext
    /// The current list of items
    public var items: [SQLItem] = []
    /// The list of all the statements that have been executed
    public var statements: [String] = []
    /// The most recent error mssage
    public var errorMessage: String? = nil

    /// A summary of the last statement that did something interesting like insert or delete
    public var lastActionSQL: String? {
        statements.last(where: { sql in
            !sql.hasPrefix("PRAGMA ") && !sql.hasPrefix("SELECT ")
        })
    }

    /// Create the database context and initialize/migrate the schems
    public init(name: String) throws {
        let dir = URL.applicationSupportDirectory
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        let ctx = try SQLContext(path: dir.appendingPathComponent(name).path, flags: [.create, .readWrite])
        self.context = ctx

        // track all SQL statements that have been executed
        ctx.trace { sql in
            logger.info("SQLPlayground: \(sql)")
            self.statements.append(sql)
        }

        try createOrMigrateSchema()
        try readItems()
    }

    private func createOrMigrateSchema() throws {
        // schema creation and migration is tracked in the database's userVersion
        if context.userVersion < 1 {
            for ddl in SQLItem.table.createTableSQL(columns: [SQLItem.id, SQLItem.name, SQLItem.date]) {
                try context.exec(ddl)
            }
            context.userVersion = 1
        }

        // version 2 of the schema adds the "SORT_ORDER" column, so we add it here and bump the userVersion
        if context.userVersion < 2 {
            for ddl in SQLItem.table.addColumnSQL(column: SQLItem.sortOrder) {
                try context.exec(ddl)
            }
            context.userVersion = 2
        }

        if context.userVersion < 3 {
            // future schema migrations go here…
            //context.userVersion = 3
        }
    }

    /// Perform the given operation and reload all the rows afterwards
    @discardableResult private func reloading<T>(_ f: () throws -> T) -> Swift.Result<T, Error> {
        defer { try? readItems() }
        do {
            return try .success(f())
        } catch {
            logger.error("error performing operation: \(error)")
            self.errorMessage = error.localizedDescription
            return .failure(error)
        }
    }

    /// Read all the items from the database, storing them in the observable `items` property
    func readItems() throws {
        self.items = try context.query(SQLItem.self)
            .orderBy(SQLItem.sortOrder, order: .descending)
            .eval().load()
    }

    /// Add a new item to the database
    public func createItem(name: String = "") {
        reloading {
            let maxSort = items.compactMap(\.sortOrder).max() ?? 0.0
            let item = SQLItem(name: name, date: Date(), sortOrder: maxSort + 100.0)
            try context.insert(item)
        }
    }

    /// Update an existing item in the database
    public func updateItem(_ item: SQLItem) {
        reloading {
            try context.update(item)
        }
    }

    /// Delete the items at the given offsets in the `items` array
    public func deleteItems(atOffsets offsets: Array<Int>) {
        reloading {
            try context.delete(instances: offsets.map({ items[$0] }))
        }
    }

    /// Move the items from the given `source` offsets in the `items` array to the given `destination` index
    public func moveItems(fromOffsets source: Array<Int>, toOffset destination: Int) {
        reloading {
            for index in source {
                var item = items[index]
                // update the "sortOrder" column to be halfway between the two adjacent items, or max+100.0 for moving to the first row
                let orderOffset = 100.0
                let nextOrder = destination == items.count ? 0.0 : items[destination].sortOrder ?? 0.0
                let prevOrder = destination == 0 ? 0.0 : items[destination - 1].sortOrder ?? 0.0
                item.sortOrder = destination == 0 ? (nextOrder + orderOffset)
                    : destination == items.count ? (prevOrder - orderOffset)
                    : (nextOrder + ((prevOrder - nextOrder) / 2.0))
                try context.update(item)
            }
        }
    }
}
