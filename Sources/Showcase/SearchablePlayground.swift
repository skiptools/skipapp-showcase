// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import Foundation
import SwiftUI

enum SearchablePlaygroundType: String, CaseIterable {
    case list
    case isSearching

    var title: String {
        switch self {
        case .list:
            return "List"
        case .isSearching:
            return "isSearching"
        }
    }
}

struct SearchablePlayground: View {
    var body: some View {
        List(SearchablePlaygroundType.allCases, id: \.self) { type in
            NavigationLink(type.title, value: type)
        }
        .navigationDestination(for: SearchablePlaygroundType.self) {
            switch $0 {
            case .list:
                ListSearchablePlayground()
                    .navigationTitle($0.title)
            case .isSearching:
                IsSearchingSearchablePlayground()
                    .navigationTitle($0.title)
            }
        }
    }
}

struct ListSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        List {
            ForEach(matchingAnimals(), id: \.self) {
                Text($0)
            }
        }
        .searchable(text: $searchText)
    }

    func matchingAnimals() -> [String] {
        return animals().filter {
            $0.lowercased().starts(with: searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
}

struct IsSearchingSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        IsSearchingView()
            .searchable(text: $searchText)
    }

    private struct IsSearchingView: View {
        @Environment(\.isSearching) var isSearching

        var body: some View {
            VStack {
                Text("isSearching:")
                if isSearching {
                    Text("YES").foregroundStyle(.green)
                } else {
                    Text("NO").foregroundStyle(.red)
                }
            }
        }
    }
}

func animals() -> [String] {
    return [
        "Alligator",
        "Ant",
        "Bat",
        "Bear",
        "Cat",
        "Cheetah",
        "Dog",
        "Dolphin",
        "Eagle",
        "Elephant",
        "Flamingo",
        "Fox",
        "Goat",
        "Gorilla",
        "Hippo",
        "Horse",
        "Ibis",
        "Insect",
        "Jackrabbit",
        "Jellyfish",
        "Kangaroo",
        "Kingfisher",
        "Lampfish",
        "Llama",
        "Manitee",
        "Monkey",
        "Narwhal",
        "Nightingale",
        "Octopus",
        "Ocelot",
        "Penguin",
        "Pufferfish",
        "Quahog",
        "Quail",
        "Rat",
        "Rhinocerous",
        "Snake",
        "Squirrel",
        "Tarantula",
        "Turtle",
        "Unicorn",
        "Vole",
        "Vulture",
        "Walrus",
        "Whale",
        "Yak",
        "Zebra"
    ]
}
