// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CRUDRepository",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v11),
        .tvOS(.v9),
        .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CRUDRepository",
            targets: ["CRUDRepository"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "10.12.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CRUDRepository",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm")
            ]),
        .testTarget(
            name: "CRUDRepositoryTests",
            dependencies: [
                "CRUDRepository",
                .product(name: "RealmSwift", package: "Realm")
            ]),
    ]
)
