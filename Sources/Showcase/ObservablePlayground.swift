// Copyright 2023–2025 Skip
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

@available(iOS 17.0, macOS 14.0, *)
struct ObservablesOuterView: View {
    @State var stateObject = PlaygroundObservable(text: "initialState")
    @Environment(PlaygroundEnvironmentObject.self) var environmentObject
    var body: some View {
        VStack {
            Text(stateObject.text)
            Text(environmentObject.text)
            ObservablesObservableView(observable: stateObject)
                .border(Color.red)
            ObservablesBindingView(text: $stateObject.text)
                .border(Color.blue)
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
