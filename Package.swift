// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "scratchpad",
    defaultLocalization: "en",
    platforms: [.macOS("13"), .iOS("16")],
    products: [
        .library(name: "AppUI", targets: ["AppUI"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.12"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.1.1"),
    ],
    targets: [
        .executableTarget(name: "AppDroid",
            dependencies: ["AppUIKt", .product(name: "SkipDrive", package: "skip")]),

        // The Swift side of the app's user interface (SwiftUI)
        .target(name: "AppUI",
            dependencies: [.product(name: "SkipUI", package: "skip-ui", condition: .when(platforms: [.macOS]))],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "AppUITests", dependencies: ["AppUI"],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
