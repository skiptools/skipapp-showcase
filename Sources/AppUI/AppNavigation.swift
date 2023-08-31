// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import OSLog
import SwiftUI

/// The logger to use for the app. Directs to the oslog on Darwin and logcat on Android.
let logger = Logger(subsystem: "app.ui", category: "AppUI")

struct NavigationView: View {
    @State var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            ContentView()
                .navigationDestination(for: String.self) {
                    switch $0 {
                    case "Button":
                        ButtonView()
                    default:
                        EmptyView()
                    }
                }
        }
    }
}

struct ButtonView: View {
    var body: some View {
        EmptyView()
    }
}
