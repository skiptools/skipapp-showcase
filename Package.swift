// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "scratchpad",
    defaultLocalization: "en",
    platforms: [.macOS("13"), .iOS("16")],
    products: [
        .library(name: "AppUI", targets: ["AppUI"]),
        .library(name: "AppUIKt", targets: ["AppUIKt"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.12"),
        .package(url: "https://source.skip.tools/skip-unit.git", from: "0.2.0"),
        .package(url: "https://source.skip.tools/skip-lib.git", from: "0.3.0"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "0.1.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.1.1"),
    ],
    targets: [
        .executableTarget(name: "AppDroid",
            dependencies: ["AppUIKt", .product(name: "SkipDrive", package: "skip")]),

        // The Swift side of the app's user interface (SwiftUI)
        .target(name: "AppUI",
            dependencies: [],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "preflight", package: "skip")]),
        .testTarget(name: "AppUITests", dependencies: ["AppUI"],
            plugins: [.plugin(name: "preflight", package: "skip")]),

        // The Kotlin side of the app's user interface (Jetpack Compose)
        .target(name: "AppUIKt",
            dependencies: [
                .product(name: "SkipUnitKt", package: "skip-unit"),
                .product(name: "SkipLibKt", package: "skip-lib"),
                .product(name: "SkipFoundationKt", package: "skip-foundation"),
                .product(name: "SkipUIKt", package: "skip-ui"),
            ],
            resources: [.process("Skip")],
            plugins: [.plugin(name: "transpile", package: "skip"), .plugin(name: "skipbuild", package: "skip")]),
        .testTarget(name: "AppUIKtTests",
            dependencies: [
                "AppUIKt",
                .product(name: "SkipUnit", package: "skip-unit"),
            ], resources: [.process("Skip")],
            plugins: [.plugin(name: "transpile", package: "skip")]),
    ]
)
