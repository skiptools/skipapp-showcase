#if canImport(SkipDrive)
import Foundation
import SkipDrive

/// The name of the app's Swift target in the Package.swift
let appName = "AppUI"

/// The name of the SPM package in which this app is bundled
let packageName = "skipapp"

// Android app launcher for Skip app
@available(macOS 13, macCatalyst 16, *)
@main public struct AndroidAppMain : GradleHarness {
    static func main() async throws {
        do {
            print("Launching App in Android Emulator (via Gradle)")
            let appId = ProcessInfo.processInfo.environment["PRODUCT_BUNDLE_IDENTIFIER"] ?? "app.ui"

            // Xcode should set PRODUCT_BUNDLE_IDENTIFIER automatically from the App.xcconfig for you
            //for (key, value) in ProcessInfo.processInfo.environment.sorted(by: { $0.key < $1.key }) {
            //    print("  env: \(key)=\(value)")
            //}
            //fatalError("Environment variable PRODUCT_BUNDLE_IDENTIFIER must be set to app id")

            try await AndroidAppMain().launch(appName: appName, appId: appId, packageName: packageName)
        } catch {
            print("Error launching: \(error)")
            //print("\(#file):\(#line):\(#column): error: AppDroid: \(error.localizedDescription)")
            //throw error // results in a fatalError
            exit(1)
        }
    }
}
#endif
