// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebClient",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "WebClient",
            targets: ["WebClient"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "WebClient",
            dependencies: []),
        .testTarget(
            name: "WebClientTests",
            dependencies: ["WebClient"]),
    ]
)
