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
        dependencies: ["AdventOfCode2023", .product(name: "Testing", package: "swift-testing")]
    ),
    .testTarget(
        name: "AdventOfCodeKitTests",
        dependencies: ["AdventOfCodeKit", .product(name: "Testing", package: "swift-testing")]
    ),
]
var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.5"),
    .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
    .package(url: "https://github.com/apple/swift-testing", revision: "0b5c648b5329bac107064950fa1b19858d581103"),
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
