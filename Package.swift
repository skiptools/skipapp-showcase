// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "PlaygroundApp",
    defaultLocalization: "en",
    platforms: [.macOS("13"), .iOS("16")],
    products: [
        .library(name: "PlaygroundApp", type: .dynamic, targets: ["PlaygroundAppUI"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.56"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.1.14"),
    ],
    targets: [
        .target(name: "PlaygroundAppUI",
            dependencies: [.product(name: "SkipUI", package: "skip-ui")],
            path: "Sources/AppUI",
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
