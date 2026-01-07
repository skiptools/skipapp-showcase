// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "skipapp-showcase",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "ShowcaseApp", type: .dynamic, targets: ["Showcase"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.4.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.26.0"),
        .package(url: "https://source.skip.tools/skip-av.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-kit.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-sql.git", "0.12.1"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-web.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-device.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-motion.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-keychain.git", "0.3.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-marketplace.git", "0.0.0"..<"2.0.0"),
        .package(url: "https://source.skip.tools/skip-authentication-services.git", "0.0.0"..<"2.0.0"),
    ],
    targets: [
        .target(name: "Showcase", dependencies: [
            .product(name: "SkipUI", package: "skip-ui"),
            .product(name: "SkipAV", package: "skip-av"),
            .product(name: "SkipKit", package: "skip-kit"),
            .product(name: "SkipSQL", package: "skip-sql"),
            .product(name: "SkipWeb", package: "skip-web"),
            .product(name: "SkipDevice", package: "skip-device"),
            .product(name: "SkipMotion", package: "skip-motion"),
            .product(name: "SkipKeychain", package: "skip-keychain"),
            .product(name: "SkipMarketplace", package: "skip-marketplace"),
            .product(name: "SkipAuthenticationServices", package: "skip-authentication-services"),
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
