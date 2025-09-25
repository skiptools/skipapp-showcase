// Copyright 2023–2025 Skip
import SwiftUI

enum SearchablePlaygroundType: String, CaseIterable {
    case list
    case plainList
    case grid
    case lazyStack
    case submit
    case isSearching
    case withoutNavStack

    var title: String {
        switch self {
        case .list:
            return "List"
        case .plainList:
            return "Plain style"
        case .grid:
            return "LazyVGrid"
        case .lazyStack:
            return "LazyVStack"
        case .submit:
            return "Submit"
        case .isSearching:
            return "isSearching"
        case .withoutNavStack:
            return "Without NavStack"
        }
    }
}

struct SearchablePlayground: View {
    @State var isPresentingWithoutNavStack = false

    var body: some View {
        List(SearchablePlaygroundType.allCases, id: \.self) { type in
            if type == .withoutNavStack {
                Button(type.title) {
                    isPresentingWithoutNavStack = true
                }
            } else {
                NavigationLink(type.title, value: type)
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "SearchablePlayground.swift")
        }
        .navigationDestination(for: SearchablePlaygroundType.self) {
            switch $0 {
            case .list:
                ListSearchablePlayground()
                    .navigationTitle($0.title)
            case .plainList:
                PlainListSearchablePlayground()
                    .navigationTitle($0.title)
            case .grid:
                GridSearchablePlayground()
                    .navigationTitle($0.title)
            case .lazyStack:
                LazyVStackSearchablePlayground()
                    .navigationTitle($0.title)
            case .submit:
                SubmitSearchablePlayground()
                    .navigationTitle($0.title)
            case .isSearching:
                IsSearchingSearchablePlayground()
                    .navigationTitle($0.title)
            case .withoutNavStack:
                EmptyView()
            }
        }
        #if os(macOS)
        .sheet(isPresented: $isPresentingWithoutNavStack) {
            WithoutNavStackSearchablePlayground()
        }
        #else
        .fullScreenCover(isPresented: $isPresentingWithoutNavStack) {
            WithoutNavStackSearchablePlayground()
        }
        #endif
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

struct PlainListSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        List {
            ForEach(matchingAnimals(), id: \.self) {
                Text($0)
            }
        }
        .listStyle(.plain)
        .searchable(text: $searchText)
    }

    func matchingAnimals() -> [String] {
        return animals().filter {
            $0.lowercased().starts(with: searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
}

struct GridSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(0..<100) { index in
                    ZStack {
                        Color.yellow
                        Text(String(describing: index))
                    }
                    .frame(height: 80)
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct LazyVStackSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(matchingAnimals(), id: \.self) {
                    Text($0)
                }
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

struct SubmitSearchablePlayground: View {
    @State var searchText = ""
    @State var matchingAnimals = animals()

    var body: some View {
        List {
            ForEach(matchingAnimals, id: \.self) {
                Text($0)
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            matchingAnimals = animals().filter {
                $0.lowercased().starts(with: searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }
    }
}

struct IsSearchingSearchablePlayground: View {
    @State var searchText = ""

    var body: some View {
        IsSearchingView()
            .searchable(text: $searchText)
    }

    struct IsSearchingView: View {
        @Environment(\.isSearching) var isSearching

        var body: some View {
            List {
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

struct WithoutNavStackSearchablePlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var searchText = ""

    var body: some View {
        List {
            Button("Dismiss") { dismiss() }
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
