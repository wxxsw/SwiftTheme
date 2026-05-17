// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTheme",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "SwiftTheme",
            targets: ["SwiftTheme"]),
    ],
    targets: [
        .target(
            name: "SwiftTheme",
            path: "Sources",
            resources: [
                .copy("PrivacyInfo.xcprivacy")
            ]),
    ]
)
