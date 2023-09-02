// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import OSLog
import SwiftUI

let logger = Logger(subsystem: "app.ui", category: "AppUI")

enum Playground: String, CaseIterable {
    case color
    case font
    case button
    case border
    case spacer
    case fixedContentList
    case indexedContentList
    case collectionContentList
    case observable
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(Playground.allCases, id: \.rawValue) { playground in
                NavigationLink(value: playground) {
                    Text(playground.rawValue.uppercased())
                }
                .padding()
            }
            .navigationDestination(for: Playground.self) {
                switch $0 {
                case .color:
                    ColorPlayground()
                case .font:
                    FontPlayground()
                case .button:
                    ButtonPlayground()
                case .border:
                    BorderPlayground()
                case .spacer:
                    SpacerPlayground()
                case .fixedContentList:
                    FixedContentListPlayground()
                case .indexedContentList:
                    IndexedContentListPlayground()
                case .collectionContentList:
                    CollectionContentListPlayground()
                case .observable:
                    ObservablePlayground()
                }
            }
        }
    }
}
