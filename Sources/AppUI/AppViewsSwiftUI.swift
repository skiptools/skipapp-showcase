// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
#if !SKIP
import Foundation
import AppModel
import SwiftUI

public protocol AppUIApp : App {
}

/// The entry point to the app, which simply loads the `ContentView` from the `AppUI` module.
public extension AppUIApp {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#endif
