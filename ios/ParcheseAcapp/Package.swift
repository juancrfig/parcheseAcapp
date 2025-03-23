// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ParcheseAcapp",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ParcheseAcapp",
            targets: ["App", "Features", "Core"]
        )
    ],
    dependencies: [
        // Add external dependencies here as needed
    ],
    targets: [
        .target(
            name: "App",
            dependencies: ["Features", "Core"]
        ),
        .target(
            name: "Features",
            dependencies: ["Core"]
        ),
        .target(
            name: "Core",
            dependencies: []
        ),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        )
    ]
) 