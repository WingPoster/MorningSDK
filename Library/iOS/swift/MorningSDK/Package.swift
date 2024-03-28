// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MorningSDK",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MorningSDK",
            targets: ["MorningSDK"]),
        .library(
            name: "libcurl",
            targets: ["libcurl"]),
        .library(
            name: "libcrypto",
            targets: ["libcrypto"]),
        .library(
            name: "libnghttp2",
            targets: ["libnghttp2"]),
        .library(
            name: "libssl",
            targets: ["libssl"]),
        .library(
            name: "MobileShield",
            targets: ["MobileShield"]),
        .library(
            name: "WebRTC",
            targets: ["WebRTC"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MorningSDK",
            dependencies: ["MobileShield", "WebRTC"]),
        .binaryTarget(name: "libcurl",
                      path: "BinaryFramework/libcurl.xcframework"),
        .binaryTarget(name: "libcrypto",
                      path: "BinaryFramework/libcrypto.xcframework"),
        .binaryTarget(name: "libnghttp2",
                      path: "BinaryFramework/libnghttp2.xcframework"),
        .binaryTarget(name: "libssl",
                      path: "BinaryFramework/libssl.xcframework"),
        .binaryTarget(name: "MobileShield",
                      path: "BinaryFramework/MobileShield.xcframework"),
        .binaryTarget(name: "WebRTC",
                      path: "BinaryFramework/WebRTC.xcframework"),
        .testTarget(
            name: "MorningSDKTests",
            dependencies: ["MobileShield"]),
    ]
)
