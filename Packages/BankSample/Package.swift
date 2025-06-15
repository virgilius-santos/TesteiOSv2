// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BankSample",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BankSample",
            targets: ["BankSample"]),
    ],
    dependencies: [
        .package(path: "Network"),
        .package(path: "KeyChain"),
        .package(path: "FoundationUtils"),
    ],
    targets: [
        .target(
            name: "BankSample",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "KeyChain", package: "KeyChain"),
                .product(name: "FoundationUtils", package: "FoundationUtils"),
            ]),
        .testTarget(
            name: "BankSampleTests",
            dependencies: ["BankSample"]),
    ]
)
