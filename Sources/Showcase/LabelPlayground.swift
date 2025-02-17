// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct LabelPlayground: View {
    #if os(macOS)
    let placement: ToolbarItemPlacement = .automatic
    #else
    let placement: ToolbarItemPlacement = .topBarLeading
    #endif
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Label {
                    Text(".init(_:icon:)")
                } icon: {
                    Image(systemName: "star.fill")
                }
                Label(".init(_:systemImage:)", systemImage: "star.fill")
                Label(".font(.title)", systemImage: "star.fill")
                    .font(.title)
                Label(".foregroundStyle(.red)", systemImage: "star.fill")
                    .foregroundStyle(.red)

                VStack {
                    Label(".tint(.red)", systemImage: "star.fill")
                        .tint(.red)
                    Text("Note: tint should not affect Label appearance")
                        .font(.caption)
                }

                Section("Label Styles") {
                    Label("Icon + Title", systemImage: "heart.fill")
                        .labelStyle(.titleAndIcon)
                    Label("Title Only", systemImage: "heart.fill")
                        .labelStyle(.titleOnly)
                    HStack {
                        Text("Icon Only:")
                            .foregroundStyle(.secondary)
                        Label("Icon Only", systemImage: "heart.fill")
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: placement
                ) {
                    Label("Icon Only", systemImage: "heart.fill")
                    Label("+ Title", systemImage: "star.fill")
                        .labelStyle(.titleAndIcon)
                    Label("Title Only", systemImage: "star.fill")
                        .labelStyle(.titleOnly)
                }
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "LabelPlayground.swift")
        }
    }
}

