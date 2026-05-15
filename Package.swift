// swift-tools-version: 6.0
import PackageDescription
import Foundation

// SKIP_MODE selects between Skip Lite (default) and Skip Fuse for the Showcase app.
// Set SKIP_MODE=fuse to depend on SkipFuseUI + SkipSQLPlus and compile with SKIP_FUSE_MODE defined,
// which also causes skipstone to build the Showcase module in `native` mode
// (Sources/Showcase/Skip/skip.yml sets `mode: 'automatic'`, which becomes 'native' when SkipFuse is present).
let fuse = (ProcessInfo.processInfo.environment["SKIP_MODE"] ?? "lite") == "fuse"

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        // The Skip Fuse Android build invokes `swift build --product Showcase`,
        // so the library product must share its name with the target.
        .library(name: "Showcase", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.7.7"),
        // UI/SQL/AV dependencies are appended at the bottom based on SKIP_MODE
        .package(url: "https://source.skip.tools/skip-kit.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-sql.git", "0.16.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-web.git", "0.9.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-device.git", "0.4.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-motion.git", "0.7.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-keychain.git", "0.3.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-marketplace.git", "0.2.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-authentication-services.git", "0.0.2"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-notify.git", "0.1.4"..<"2.0.0"),
    ],
    targets: [
        .target(name: "Showcase", dependencies: [
            // UI/SQL/AV product dependencies are appended below
            .product(name: "SkipKit", package: "skip-kit"),
            .product(name: "SkipWeb", package: "skip-web"),
            .product(name: "SkipDevice", package: "skip-device"),
            .product(name: "SkipMotion", package: "skip-motion"),
            .product(name: "SkipKeychain", package: "skip-keychain"),
            .product(name: "SkipMarketplace", package: "skip-marketplace"),
            .product(name: "SkipAuthenticationServices", package: "skip-authentication-services"),
            .product(name: "SkipNotify", package: "skip-notify"),
        ], resources: [.process("Resources")],
           swiftSettings: fuse ? [.define("SKIP_FUSE_MODE")] : [],
           plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)

if fuse {
    package.dependencies += [
        // Pin to the same versions skipapp-showcase-fuse last shipped against,
        // so the Fuse-side bridging analysis succeeds with their SkipUI revision.
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", "1.14.1"..<"1.15.0"),
    ]
    package.targets[0].dependencies += [
        .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
    ]
    // SkipAV is intentionally NOT depended on in Fuse mode: its `bridging: true`
    // transpilation currently fails ('SkipLogger' is not a bridged type) when
    // the primary module is native. VideoPlayerPlayground.swift is stubbed.
} else {
    package.dependencies += [
        // Use the newest tagged SkipUI: the Fuse-source playgrounds rely on
        // SwiftUI material and stepper APIs that older SkipUI revisions don't
        // expose to the transpiler yet.
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.54.0"),
        .package(url: "https://source.skip.tools/skip-av.git", "0.6.2"..<"2.0.0"),
    ]
    package.targets[0].dependencies += [
        .product(name: "SkipUI", package: "skip-ui"),
        .product(name: "SkipAV", package: "skip-av"),
    ]
}

// SQLPlayground references types from SkipSQL/SkipSQLCore (e.g. SQLValueType
// like .long/.text/.real) as well as the SkipSQLPlus-only .plus configuration.
// Depend on both unconditionally so the imports resolve in Lite and Fuse modes
// without #if conditionals, which would otherwise confuse the Fuse bridge
// generator (it doesn't yet honor SKIP_FUSE_MODE in import lines).
package.targets[0].dependencies += [
    .product(name: "SkipSQL", package: "skip-sql"),
    .product(name: "SkipSQLPlus", package: "skip-sql"),
]

// SKIP_DEPENDENCY_ROOT overrides every skiptools dependency with a local
// `.package(path: ROOT/<repo>)` checkout, matching the pattern used in
// Net-Skip and other Skip apps. This lets developers iterate against unreleased
// Skip library changes; in CI/normal builds the variable is unset and remote
// versions resolve as usual.
if let dependencyRoot = ProcessInfo.processInfo.environment["SKIP_DEPENDENCY_ROOT"] {
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
}
