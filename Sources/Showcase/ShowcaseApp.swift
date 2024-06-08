// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import Foundation
import OSLog
import SwiftUI

let logger = Logger(subsystem: "showcase.app", category: "ShowcaseApp")

/// URL string of the source this app.
let showcaseSourceURLString = "https://source.skip.tools/skipapp-showcase/tree/main/"
let playgroundPath = "Sources/Showcase/"

/// The Android SDK number we are running against, or `nil` if not running on Android
let androidSDK = ProcessInfo.processInfo.environment["android.os.Build.VERSION.SDK_INT"].flatMap({ Int($0) })

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
public struct RootView : View {
    public init() {
    }

    public var body: some View {
        ContentView()
            .onAppear {
                logger.log("Welcome to Skip on \(androidSDK != nil ? "Android" : "Darwin")!")
                logger.warning("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

#if !SKIP
public protocol ShowcaseApp : App {
}

/// The entry point to the Showcase app.
/// The concrete implementation is in the ShowcaseApp module.
public extension ShowcaseApp {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

#endif
