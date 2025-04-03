// swift-tools-version: 5.9
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception
import PackageDescription
import Foundation

// Set SKIP_ZERO=1 to build without Skip libraries
let zero = ProcessInfo.processInfo.environment["SKIP_ZERO"] != nil
let skipstone = !zero ? [Target.PluginUsage.plugin(name: "skipstone", package: "skip")] : []

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v14), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "ShowcaseApp", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.4.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.26.0"),
        .package(url: "https://source.skip.tools/skip-av.git", "0.0.0"..<"2.0.0")
    ],
    targets: [
        .target(name: "Showcase", dependencies: (zero ? [] : [
            .product(name: "SkipUI", package: "skip-ui"),
            .product(name: "SkipAV", package: "skip-av")
        ]), resources: [.process("Resources")], plugins: skipstone),
    ]
)
