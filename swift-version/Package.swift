// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "PortfolioWebsite",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 Vapor
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        // 🗄️ Database
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.7.2"),
        // 🍃 Leaf for templating
        .package(url: "https://github.com/vapor/leaf.git", from: "4.2.4"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Leaf", package: "leaf"),
            ]
        ),
    ]
)
