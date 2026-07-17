// Copyright 2023–2026 Skip
import SwiftUI

struct ContextMenuPlayground: View {
    @State var lastAction = "None"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Last action: \(lastAction)")
                    .font(.headline)

                Text("Long press on the items below to show context menus")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Long Press Me")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                    .contextMenu {
                        Button("Copy") { lastAction = "Copy" }
                        Button("Paste") { lastAction = "Paste" }
                        Button("Delete", role: .destructive) { lastAction = "Delete" }
                    }

                Label("With Labels", systemImage: "star.fill")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                    .contextMenu {
                        Button(action: { lastAction = "Favorite" }) {
                            Label("Favorite", systemImage: "heart.fill")
                        }
                        Button(action: { lastAction = "Share" }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        Button(action: { lastAction = "Flag" }) {
                            Label("Flag", systemImage: "plus")
                        }
                    }

                Image(systemName: "house.fill")
                    .font(.system(size: 60))
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                    .contextMenu {
                        Button("Save Image") { lastAction = "Save Image" }
                        Button("Copy Image") { lastAction = "Copy Image" }
                        Divider()
                        Button("Delete", role: .destructive) { lastAction = "Delete Image" }
                    }

                Button {
                    lastAction = "Button Tapped"
                } label: {
                    Text("Tappable Button")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
                .contextMenu {
                    Button("Edit") { lastAction = "Edit" }
                    Button("Duplicate") { lastAction = "Duplicate" }
                    Button("Delete", role: .destructive) { lastAction = "Delete" }
                }

                Text("With Sections")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(8)
                    .contextMenu {
                        Section("Edit") {
                            Button("Cut") { lastAction = "Cut" }
                            Button("Copy") { lastAction = "Copy" }
                            Button("Paste") { lastAction = "Paste" }
                        }
                        Section("Other") {
                            Button("Select All") { lastAction = "Select All" }
                        }
                    }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ContextMenuPlayground.swift")
        }
    }
}
