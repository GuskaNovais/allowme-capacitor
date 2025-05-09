// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AllowmeCapacitor",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "AllowmeCapacitor",
            targets: ["AllowMeCapacitorPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "AllowMeCapacitorPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/AllowMeCapacitorPlugin"),
        .testTarget(
            name: "AllowMeCapacitorPluginTests",
            dependencies: ["AllowMeCapacitorPlugin"],
            path: "ios/Tests/AllowMeCapacitorPluginTests")
    ]
)