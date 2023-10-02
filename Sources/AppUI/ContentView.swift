// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import OSLog
import SwiftUI

let logger = Logger(subsystem: "playground.app.ui", category: "PlaygroundApp")

enum PlaygroundType: String, CaseIterable {
    case color
    case text
    case symbol
    case button
    case toggle
    case progressView
    case textField
    case border
    case spacer
    case list
    case state
    case observable

    var title: String {
        switch self {
        case .color:
            return "Color"
        case .text:
            return "Text"
        case .symbol:
            return "Symbol"
        case .button:
            return "Button"
        case .toggle:
            return "Toggle"
        case .progressView:
            return "ProgressView"
        case .textField:
            return "TextField"
        case .border:
            return "Border"
        case .spacer:
            return "Spacer"
        case .list:
            return "List"
        case .state:
            return "State"
        case .observable:
            return "Observable"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(PlaygroundType.allCases, id: \.rawValue) { playground in
                NavigationLink(playground.title, value: playground)
            }
            .navigationDestination(for: PlaygroundType.self) {
                switch $0 {
                case .color:
                    ColorPlayground()
                        .navigationTitle($0.title)
                case .text:
                    TextPlayground()
                        .navigationTitle($0.title)
                case .symbol:
                    SymbolPlayground()
                        .navigationTitle($0.title)
                case .button:
                    ButtonPlayground()
                        .navigationTitle($0.title)
                case .toggle:
                    TogglePlayground()
                        .navigationTitle($0.title)
                case .progressView:
                    ProgressViewPlayground()
                        .navigationTitle($0.title)
                case .textField:
                    TextFieldPlayground()
                        .navigationTitle($0.title)
                case .border:
                    BorderPlayground()
                        .navigationTitle($0.title)
                case .spacer:
                    SpacerPlayground()
                        .navigationTitle($0.title)
                case .list:
                    ListPlayground()
                        .navigationTitle($0.title)
                case .state:
                    StatePlayground()
                        .navigationTitle($0.title)
                case .observable:
                    ObservablePlayground()
                        .navigationTitle($0.title)
                }
            }
        }
    }
}
