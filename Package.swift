// swift-tools-version: 5.9

import PackageDescription

var products: [Product] = [
    .library(name: "AdventOfCode2023", targets: ["AdventOfCode2023"]),
    .library(name: "AdventOfCodeKit", targets: ["AdventOfCodeKit"]),
]
var targets: [Target] = [
    .target(
        name: "AdventOfCode2023",
        dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Collections", package: "swift-collections"),
            .product(name: "Numerics", package: "swift-numerics"),
            .product(name: "Parsing", package: "swift-parsing"),
            .target(name: "AdventOfCodeKit"),
        ],
        resources: [
            .copy("Inputs")
        ]
    ),
    .target(
        name: "AdventOfCodeKit",
        dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "DequeModule", package: "swift-collections"),
        ]
    ),
    .testTarget(
        name: "AdventOfCode2023Tests",
        dependencies: ["AdventOfCode2023"]
    ),
    .testTarget(
        name: "AdventOfCodeKitTests",
        dependencies: ["AdventOfCodeKit"]
    ),
]
var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.5"),
    .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0"),
]
#if os(macOS)
    products.append(.executable(name: "aoc-cli", targets: ["AdventOfCodeCLI"]))
    targets.append(
        .executableTarget(
            name: "AdventOfCodeCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ))
    dependencies.append(.package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.3"))
#endif

let package = Package(
    name: "AdventOfCode2023",
    platforms: [.macOS(.v13)],
    products: products,
    dependencies: dependencies,
    targets: targets
)
