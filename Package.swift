// swift-tools-version: 6.0
import PackageDescription

// switch between "lite" (Skip Lite transpiled) and "fuse" (Skip Fuse compiled)
let SKIP_MODE = Context.environment["SKIP_MODE"] ?? "lite"

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "Showcase", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.21"),
        SKIP_MODE == "lite" ? .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0") : .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-av.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-kit.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-sql.git", "0.12.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-web.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-device.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-motion.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-keychain.git", "0.3.0"..<"2.0.0"),
    ],
    targets: [
        .target(name: "Showcase", dependencies: [
            SKIP_MODE == "lite" ? .product(name: "SkipUI", package: "skip-ui") : .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
            .product(name: "SkipAV", package: "skip-av"),
            .product(name: "SkipKit", package: "skip-kit"),
            .product(name: "SkipSQLPlus", package: "skip-sql"),
            .product(name: "SkipWeb", package: "skip-web"),
            .product(name: "SkipDevice", package: "skip-device"),
            .product(name: "SkipMotion", package: "skip-motion"),
            .product(name: "SkipKeychain", package: "skip-keychain"),
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
