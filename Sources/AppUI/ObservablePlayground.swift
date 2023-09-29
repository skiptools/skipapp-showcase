// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI
#if canImport(Observation)
import Observation
#endif

struct ObservablePlayground: View {
    var body: some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            #if os(macOS)
            #else
            ObservablesOuterView()
                .environmentObject(PlaygroundEnvironmentObject(text: "initialEnvironment"))
            #endif
        } else {
            Text("iOS 17 / macOS 14 required")
        }
    }
}

#if os(macOS) // crashes on macOS 13 hosts: type metadata completion function for PlaygroundObservable ()
#else
class PlaygroundEnvironmentObject: ObservableObject {
    @Published var text: String
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
    @EnvironmentObject var environmentObject: PlaygroundEnvironmentObject
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
    @EnvironmentObject var environmentObject: PlaygroundEnvironmentObject
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
#endif
