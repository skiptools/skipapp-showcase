// swift-tools-version: 5.9
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import PackageDescription
import Foundation

// Set SKIP_ZERO=1 to build without Skip libraries
let zero = ProcessInfo.processInfo.environment["SKIP_ZERO"] != nil
let skipstone = !zero ? [Target.PluginUsage.plugin(name: "skipstone", package: "skip")] : []

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "ShowcaseApp", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.7.42"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.3.38"),
        .package(url: "https://source.skip.tools/skip-av.git", from: "0.0.2")
    ],
    targets: [
        .target(name: "Showcase", dependencies: (zero ? [] : [
            .product(name: "SkipUI", package: "skip-ui"),
            .product(name: "SkipAV", package: "skip-av")
        ]), resources: [.process("Resources")], plugins: skipstone),
    ]
)
