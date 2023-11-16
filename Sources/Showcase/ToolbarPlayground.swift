// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum ToolbarPlaygroundType: String, CaseIterable {
    case `default`
    case custom
    case toolbarItem
    case toolbarItemGroup
    case topLeadingItem
    case topLeadingItemGroup
    case topLeadingTrailingItems

    var title: String {
        switch self {
        case .default:
            return "Default"
        case .custom:
            return "Custom"
        case .toolbarItem:
            return "ToolbarItem"
        case .toolbarItemGroup:
            return "ToolbarItemGroup"
        case .topLeadingItem:
            return ".topLeading"
        case .topLeadingItemGroup:
            return ".topLeading Group"
        case .topLeadingTrailingItems:
            return "Both Top"
        }
    }
}

struct ToolbarPlayground: View {
    var body: some View {
        List(ToolbarPlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .navigationDestination(for: ToolbarPlaygroundType.self) {
            switch $0 {
            case .default:
                DefaultToolbarItemPlayground()
                    .navigationTitle($0.title)
            case .custom:
                CustomToolbarItemPlayground()
                    .navigationTitle($0.title)
            case .toolbarItem:
                ToolbarItemPlayground(placement: ToolbarItemPlacement.automatic, placement2: ToolbarItemPlacement.automatic)
                    .navigationTitle($0.title)
            case .toolbarItemGroup:
                ToolbarItemGroupPlayground(placement: ToolbarItemPlacement.automatic)
                    .navigationTitle($0.title)
            case .topLeadingItem:
                ToolbarItemPlayground(placement: ToolbarItemPlacement.topBarLeading)
                    .navigationTitle($0.title)
            case .topLeadingItemGroup:
                ToolbarItemGroupPlayground(placement: ToolbarItemPlacement.topBarLeading)
                    .navigationTitle($0.title)
            case .topLeadingTrailingItems:
                ToolbarItemPlayground(placement: ToolbarItemPlacement.topBarLeading, placement2: ToolbarItemPlacement.topBarTrailing)
                    .navigationTitle($0.title)
            }
        }
    }
}

struct DefaultToolbarItemPlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var firstTapCount = 0
    @State var secondTapCount = 0

    var body: some View {
        List {
            Button("Pop") {
                dismiss()
            }
            ForEach(0..<100) { i in
                Text("Content \(i)")
            }
        }
        .toolbar {
            Button("First: \(firstTapCount)") {
                firstTapCount += 1
            }
            Button("Second: \(secondTapCount)") {
                secondTapCount += 1
            }
        }
    }
}

struct CustomToolbarItemPlayground: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            Button("Pop") {
                dismiss()
            }
            ForEach(0..<100) { i in
                Text("Content \(i)")
            }
        }
        .toolbar {
            Ellipse()
                .fill(.red.gradient)
                .frame(width: 100.0, height: 50.0)
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

struct ToolbarItemPlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var firstTapCount = 0
    @State var secondTapCount = 0
    let placement: ToolbarItemPlacement
    var placement2: ToolbarItemPlacement? = nil

    var body: some View {
        List {
            Button("Pop") {
                dismiss()
            }
            ForEach(0..<100) { i in
                Text("Content \(i)")
            }
        }
        .toolbar {
            ToolbarItem(placement: placement) {
                Button("First: \(firstTapCount)") {
                    firstTapCount += 1
                }
            }
            if let placement2 {
                ToolbarItem(placement: placement2) {
                    Button("Second: \(secondTapCount)") {
                        secondTapCount += 1
                    }
                }
            }
        }
    }
}

struct ToolbarItemGroupPlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var firstTapCount = 0
    @State var secondTapCount = 0
    let placement: ToolbarItemPlacement

    var body: some View {
        List {
            Button("Pop") {
                dismiss()
            }
            ForEach(0..<100) { i in
                Text("Content \(i)")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                Button("First: \(firstTapCount)") {
                    firstTapCount += 1
                }
                Button("Second: \(secondTapCount)") {
                    secondTapCount += 1
                }
            }
        }
    }
}
