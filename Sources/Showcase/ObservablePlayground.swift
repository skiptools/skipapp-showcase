// Copyright 2023–2026 Skip
import SwiftUI

struct ObservablePlayground: View {
    var body: some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            ObservablesOuterView()
                .environment(PlaygroundEnvironmentObject(text: "initialEnvironment"))
                .toolbar {
                    PlaygroundSourceLink(file: "ObservablePlayground.swift")
                }
        } else {
            Text("iOS 17 / macOS 14 required for Observation framework")
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
@Observable class PlaygroundEnvironmentObject {
    var text: String
    init(text: String) {
        self.text = text
    }
}

@available(iOS 17.0, macOS 14.0, *)
@Observable class PlaygroundObservable {
    var text = ""
    init(text: String) {
        self.text = text
    }
}

/// Demonstrates assigning a new `[String: Struct]` to an `@Observable` property.
/// `VersionedItem` uses identity `Equatable` (id only). The label reads
/// `items["alpha"]?.version`. Tap "Replace dictionary" to assign version 2.
@available(iOS 17.0, macOS 14.0, *)
@Observable class DictionaryPlaygroundModel {
    var items: [String: VersionedItem] = [:]

    init() {
        items = ["alpha": VersionedItem(version: 1)]
    }

    func replace() {
        items = ["alpha": VersionedItem(version: 2)]
    }
}

@available(iOS 17.0, macOS 14.0, *)
struct VersionedItem: Equatable, Hashable {
    let id: String
    var version: Int

    init(id: String = "alpha", version: Int) {
        self.id = id
        self.version = version
    }

    static func == (lhs: VersionedItem, rhs: VersionedItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@available(iOS 17.0, macOS 14.0, *)
struct ObservablesOuterView: View {
    @State var stateObject = PlaygroundObservable(text: "initialState")
    @State var dictionaryModel = DictionaryPlaygroundModel()
    @Environment(PlaygroundEnvironmentObject.self) var environmentObject
    var body: some View {
        VStack {
            Text(stateObject.text)
            Text(environmentObject.text)
            ObservablesObservableView(observable: stateObject)
                .border(Color.red)
            ObservablesBindingView(text: $stateObject.text)
                .border(Color.blue)
            DictionaryObservableView(model: dictionaryModel)
                .border(Color.green)
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
struct DictionaryObservableView: View {
    let model: DictionaryPlaygroundModel

    var body: some View {
        let displayedVersion = model.items["alpha"]?.version ?? -1
        return VStack {
            Text("Dictionary version: \(displayedVersion)")
                .accessibilityIdentifier("dictionary-version")
            Button("Replace dictionary") {
                model.replace()
            }
            .accessibilityIdentifier("dictionary-replace-button")
        }
    }
}

@available(iOS 17.0, macOS 14.0, *)
struct ObservablesObservableView: View {
    let observable: PlaygroundObservable
    @Environment(PlaygroundEnvironmentObject.self) var environmentObject
    var body: some View {
        Text(observable.text)
        Text(environmentObject.text)
        Button("Button") {
            observable.text = "observableState"
            environmentObject.text = "observableEnvironment"
        }
    }
}

struct ObservablesBindingView: View {
    @Binding var text: String
    var body: some View {
        Button("Button") {
            text = "bindingState"
        }
        .accessibilityIdentifier("binding-button")
    }
}
