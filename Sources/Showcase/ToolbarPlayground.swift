// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

enum ToolbarPlaygroundType: String, CaseIterable {
    case `default`
    case tint
    case custom
    case toolbarItem
    case toolbarItemGroup
    case topLeadingItem
    case topLeadingItemGroup
    case topLeadingBackButtonHidden
    case topLeadingTrailingItems
    case bottom
    case bottomGroup
    case bottomSpaced

    var title: String {
        switch self {
        case .default:
            return "Default"
        case .tint:
            return "Tint"
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
        case .topLeadingBackButtonHidden:
            return ".topLeading Back Hidden"
        case .topLeadingTrailingItems:
            return "Both Top"
        case .bottom:
            return "Bottom"
        case .bottomGroup:
            return "Bottom 3 Group"
        case .bottomSpaced:
            return "Bottom 3 Spaced"
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
            case .tint:
                TintToolbarItemGroupPlayground()
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
                #if os(macOS) // ToolbarItemPlacement.topBarLeading unavailable on macOS
                #else
                ToolbarItemPlayground(placement: ToolbarItemPlacement.topBarLeading)
                    .navigationTitle($0.title)
                #endif
            case .topLeadingItemGroup:
                #if os(macOS) // ToolbarItemPlacement.topBarLeading unavailable on macOS
                #else
                ToolbarItemGroupPlayground(placement: ToolbarItemPlacement.topBarLeading)
                    .navigationTitle($0.title)
                #endif
            case .topLeadingBackButtonHidden:
                #if os(macOS) // ToolbarItemPlacement.topBarLeading unavailable on macOS
                #else
                ToolbarBackButtonHiddenPlayground()
                    .navigationTitle($0.title)
                #endif
            case .topLeadingTrailingItems:
                #if os(macOS) // ToolbarItemPlacement.topBarLeading unavailable on macOS
                #else
                ToolbarItemPlayground(placement: ToolbarItemPlacement.topBarLeading, placement2: ToolbarItemPlacement.topBarTrailing)
                    .navigationTitle($0.title)
                #endif
            case .bottom:
                #if os(macOS) // ToolbarItemPlacement.bottomBar unavailable on macOS
                #else
                ToolbarItemPlayground(placement: ToolbarItemPlacement.bottomBar, placement2: ToolbarItemPlacement.bottomBar)
                    .navigationTitle($0.title)
                #endif
            case .bottomGroup:
                #if os(macOS) // ToolbarItemPlacement.bottomBar unavailable on macOS
                #else
                ToolbarBottomThreePlayground(spaced: false)
                    .navigationTitle($0.title)
                #endif
            case .bottomSpaced:
                #if os(macOS) // ToolbarItemPlacement.bottomBar unavailable on macOS
                #else
                ToolbarBottomThreePlayground(spaced: true)
                    .navigationTitle($0.title)
                #endif
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

struct TintToolbarItemGroupPlayground: View {
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
            ToolbarItemGroup {
                Button("First: \(firstTapCount)") {
                    firstTapCount += 1
                }
                .tint(.red)
                Button("Second: \(secondTapCount)") {
                    secondTapCount += 1
                }
                .tint(.green)
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

struct ToolbarBottomThreePlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var firstTapCount = 0
    @State var secondTapCount = 0
    @State var thirdTapCount = 0
    let spaced: Bool

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
            #if os(macOS) // ToolbarItemPlacement.bottomBar unavailable on macOS
            #else
            ToolbarItemGroup(placement: .bottomBar) {
                Button("First: \(firstTapCount)") {
                    firstTapCount += 1
                }
                if spaced {
                    Spacer()
                }
                Button("Second: \(secondTapCount)") {
                    secondTapCount += 1
                }
                if spaced {
                    Spacer()
                }
                Button("Third: \(thirdTapCount)") {
                    thirdTapCount += 1
                }
            }
            #endif
        }
    }
}

struct ToolbarBackButtonHiddenPlayground: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            ForEach(0..<100) { i in
                Text("Content \(i)")
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            #if os(macOS) // ToolbarItemPlacement.topBarLeading unavailable on macOS
            #else
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            #endif
        }
    }
}
