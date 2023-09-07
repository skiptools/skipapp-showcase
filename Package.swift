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
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.56"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.1.14"),
    ],
    targets: [
        .executableTarget(name: "AppDroid",
            dependencies: ["AppUI", .product(name: "SkipDrive", package: "skip")]),

        .target(name: "AppUI",
            dependencies: [.product(name: "SkipUI", package: "skip-ui", condition: .when(platforms: [.macOS]))],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),

        .testTarget(name: "AppUITests", dependencies: ["AppUI", .product(name: "SkipTest", package: "skip")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
