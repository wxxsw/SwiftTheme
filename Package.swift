// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTheme",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v11),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SwiftTheme",
            targets: ["SwiftTheme"]),
    ],
    targets: [
        .target(
            name: "SwiftTheme",
            path: "SwiftTheme")
    ],
    swiftLanguageVersions: [.v5]
)
