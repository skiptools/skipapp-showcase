// Copyright 2023–2026 Skip
import Foundation

/// URL string of the source this app.
let showcaseSourceURLString = "https://source.skip.tools/skipapp-showcase/tree/main/"
let playgroundPath = "Sources/Showcase/"

/// The Android SDK number we are running against, or `nil` if not running on Android
let androidSDK = ProcessInfo.processInfo.environment["android.os.Build.VERSION.SDK_INT"].flatMap({ Int($0) })
