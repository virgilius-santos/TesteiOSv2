// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BankSampleUIKit",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "BankSampleUIKit",
            targets: ["BankSampleUIKit"]),
    ],
    dependencies: [
        .package(path: "UIKitComponents"),
        .package(path: "FoundationUtils"),
        .package(path: "BankSample"),
    ],
    targets: [
        .target(
            name: "BankSampleUIKit",
            dependencies: [
                .product(name: "UIKitComponents", package: "UIKitComponents"),
                .product(name: "FoundationUtils", package: "FoundationUtils"),
                .product(name: "BankSample", package: "BankSample"),
            ]),
        .testTarget(
            name: "BankSampleUIKitTests",
            dependencies: ["BankSampleUIKit"]),
    ]
)
