import Foundation
import SwiftUI
#if canImport(OSLog)
import OSLog
#elseif os(Android) && !SKIP
import AndroidLogging
#endif

let logger: Logger = Logger(subsystem: "skip.showcase", category: "Showcase")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
/* SKIP @bridge */public struct ShowcaseRootView : View {
    /* SKIP @bridge */public init() {
    }

    public var body: some View {
        ContentView()
            .task {
                logger.info("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

/// Global application delegate functions.
///
/// These functions can update a shared observable object to communicate app state changes to interested views.
/// The sender for each of these functions will be either a `UIApplication` (iOS) or `AppCompatActivity` (Android)
/* SKIP @bridge */public final class ShowcaseAppDelegate : Sendable {
    /* SKIP @bridge */public static let shared = ShowcaseAppDelegate()

    private init() {
    }

    /* SKIP @bridge */public func onStart() {
        logger.debug("onStart")
    }

    /* SKIP @bridge */public func onResume() {
        logger.debug("onResume")
    }

    /* SKIP @bridge */ public func onPause() {
        logger.debug("onPause")
    }

    /* SKIP @bridge */public func onStop() {
        logger.debug("onStop")
    }

    /* SKIP @bridge */public func onDestroy() {
        logger.debug("onDestroy")
    }

    /* SKIP @bridge */public func onLowMemory() {
        logger.debug("onLowMemory")
    }
}
