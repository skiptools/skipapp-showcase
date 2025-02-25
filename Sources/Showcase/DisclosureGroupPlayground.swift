// Copyright 2023–2025 Skip
import SwiftUI

struct DisclosureGroupPlayground: View {
    @State var expanded = false
    @State var nestedModel = DisclosureGroupPlaygroundModel(title: "Multi-Level", items: ["AAAA", "BBBB", "CCCC"], nested: [DisclosureGroupPlaygroundModel(title: "Nested", items: ["1111", "2222", "3333"])])

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button("Toggle Group") {
                    withAnimation { expanded = !expanded }
                }
                .buttonStyle(.bordered)
                DisclosureGroup("DisclosureGroup", isExpanded: $expanded) {
                    Text("AAAA")
                    Text("BBBB")
                    Text("CCCC")
                }
                DisclosureGroup(nestedModel.title, isExpanded: $nestedModel.isExpanded) {
                    ForEach(nestedModel.items, id: \.self) { text in
                        Text(text)
                    }
                    ForEach($nestedModel.nested, id: \.title) { $item in
                        DisclosureGroup(item.title, isExpanded: $item.isExpanded) {
                            ForEach(item.items, id: \.self) { text in
                                Text(text)
                            }
                        }
                    }
                }
                DisclosureGroup("Disabled", isExpanded: $expanded) {
                    Text("AAAA")
                    Text("BBBB")
                    Text("CCCC")
                }
                .disabled(true)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "DisclosureGroupPlayground.swift")
        }
    }
}

struct DisclosureGroupPlaygroundModel {
    var title = ""
    var isExpanded = false
    var items: [String] = []
    var nested: [DisclosureGroupPlaygroundModel] = []
}
