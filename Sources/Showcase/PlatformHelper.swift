// Copyright 2023–2025 Skip
import Foundation

#if !SKIP
let isAndroid = false
#else
let isAndroid = true
#endif

/// The name of the current app
let appName = (Bundle.main.infoDictionary?["CFBundleName"] as? String) ?? "Unknown"

/// The current version of the app, using the main bundle's infoDictionary `CFBundleShortVersionString` property on iOS and `android.content.pm.PackageManager` `versionName` on Android.
let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "0.0.0"

/// The bundle identifier of the current app
let appIdentifier = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? "app.unknown"

/// `true` when this is a debug build, and
let isDebugBuild: Bool = {
    #if SKIP
    return (ProcessInfo.processInfo.androidContext.getApplicationInfo().flags & android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0
    #elseif DEBUG
    return true
    #else
    return false
    #endif
}()

