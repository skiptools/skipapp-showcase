// swift-tools-version: 6.1
import PackageDescription

// SKIP_MODE toggles between Skip Lite (default) and Skip Fuse for the Showcase app.
// Set SKIP_MODE=fuse to depend on SkipFuseUI + SkipSQLPlus and compile with SKIP_MODE_FUSE defined,
// which also causes skipstone to build the Showcase module in `native` mode
// (Sources/Showcase/Skip/skip.yml sets `mode: 'automatic'`, which becomes 'native' when SkipFuse is present).
//
// Example usage: SKIP_MODE=fuse skip app launch
let defaultMode = "lite"
//let defaultMode = "fuse"
let fuse = (Context.environment["SKIP_MODE"] ?? defaultMode) == "fuse"

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "Showcase", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        fuse ? .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0")
             : .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0"),        
        .package(url: "https://source.skip.tools/skip.git", from: "1.7.7"),
        .package(url: "https://source.skip.tools/skip-kit.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-av.git", "0.6.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-web.git", "0.9.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-sql.git", "0.16.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-device.git", "0.4.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-motion.git", "0.7.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-notify.git", "0.1.4"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-keychain.git", "0.3.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-marketplace.git", "0.2.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-authentication-services.git", "0.0.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-contacts.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-calendar.git", "0.0.0"..<"2.0.0"),
    ],
    targets: [
        .target(name: "Showcase", dependencies: [
            fuse ? .product(name: "SkipFuseUI", package: "skip-fuse-ui")
                 : .product(name: "SkipUI", package: "skip-ui"),
            fuse ? .product(name: "SkipSQLPlus", package: "skip-sql")
                 : .product(name: "SkipSQL", package: "skip-sql"),
            .product(name: "SkipSQL", package: "skip-sql"),
            .product(name: "SkipAV", package: "skip-av"),
            .product(name: "SkipKit", package: "skip-kit"),
            .product(name: "SkipWeb", package: "skip-web"),
            .product(name: "SkipDevice", package: "skip-device"),
            .product(name: "SkipMotion", package: "skip-motion"),
            .product(name: "SkipNotify", package: "skip-notify"),
            .product(name: "SkipKeychain", package: "skip-keychain"),
            .product(name: "SkipMarketplace", package: "skip-marketplace"),
            .product(name: "SkipAuthenticationServices", package: "skip-authentication-services"),
            .product(name: "SkipContacts", package: "skip-contacts"),
            .product(name: "SkipCalendar", package: "skip-calendar"),
        ], resources: [.process("Resources")],
                swiftSettings: [.define(fuse ? "SKIP_MODE_FUSE" : "SKIP_MODE_LITE", .when(platforms: [.android]))],
           plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

// SKIP_DEPENDENCY_ROOT overrides every skiptools dependency with a local
// `.package(path: ROOT/<repo>)` checkout.
// This lets developers iterate against unreleased
// Skip library changes; in CI/normal builds the variable is unset and remote
// versions resolve as usual.
//
// Example usage: SKIP_MODE=lite SKIP_DEPENDENCY_ROOT=/path/to/local/skip/repostories skip app launch
if let dependencyRoot = Context.environment["SKIP_DEPENDENCY_ROOT"] {
    package.dependencies = package.dependencies.map { dep in
        switch dep.kind {
        case .sourceControl(_, let location, _):
            guard let baseName = location.split(separator: "/").last?.split(separator: ".").first else {
                return dep
            }
            guard baseName.hasPrefix("skip") else {
                return dep
            }
            return Package.Dependency.package(path: dependencyRoot + "/" + baseName)
        default:
            return dep
        }
    }
    // Root-package dependencies override transitive dependencies with the same identity,
    // so also pin transitive skip libraries that the app doesn't depend on directly.
    package.dependencies.append(.package(path: dependencyRoot + "/skip-model"))
    if fuse {
        // In Fuse mode skip-ui is only reachable through skip-fuse-ui; in Lite mode it is a
        // direct dependency already mapped above (appending it again would be a duplicate).
        package.dependencies.append(.package(path: dependencyRoot + "/skip-ui"))
    }
}
