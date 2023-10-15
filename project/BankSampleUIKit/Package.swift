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
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", from: "6.5.0"),
        .package(url: "https://github.com/jrendel/SwiftKeychainWrapper", from: "4.0.0"),
        .package(path: "Network"),
        .package(path: "KeyChain"),
        .package(path: "UIKitComponents"),
        .package(path: "FoundationUtils"),
    ],
    targets: [
        .target(
            name: "BankSampleUIKit",
            dependencies: [
                .product(name: "IQKeyboardManagerSwift", package: "IQKeyboardManager"),
                .product(name: "SwiftKeychainWrapper", package: "SwiftKeychainWrapper"),
                .product(name: "Network", package: "Network"),
                .product(name: "KeyChain", package: "KeyChain"),
                .product(name: "UIKitComponents", package: "UIKitComponents"),
                .product(name: "FoundationUtils", package: "FoundationUtils"),
            ]),
        .testTarget(
            name: "BankSampleUIKitTests",
            dependencies: ["BankSampleUIKit"]),
    ]
)
