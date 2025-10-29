// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InputBarAccessoryView",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "InputBarAccessoryView", targets: ["InputBarAccessoryView"]),
    ],
    dependencies: [
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1")
    ],
    targets: [
        .target(
            name: "InputBarAccessoryView",
            dependencies: [
              .product(name: "SnapKit", package: "SnapKit")
            ],
            path: "Sources",
            exclude: ["Supporting/Info.plist"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
