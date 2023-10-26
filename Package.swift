// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "skip-showcase",
    defaultLocalization: "en",
    platforms: [.macOS("13"), .iOS("16")],
    products: [
        .library(name: "Showcase", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.6.56"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.1.14"),
    ],
    targets: [
        .target(name: "Showcase",
            dependencies: [.product(name: "SkipUI", package: "skip-ui")],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
