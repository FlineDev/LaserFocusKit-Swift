// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "LaserFocusKit",
  platforms: [.macOS(.v10_12)],
  products: [
    .library(name: "LaserFocusKit", targets: ["LaserFocusKit"]),
  ],
  dependencies: [
    // Better Codable through Property Wrappers
    .package(url: "https://github.com/marksands/BetterCodable.git", from: "0.4.0"),

    // Handy Swift features that didn't make it into the Swift standard library.
    .package(url: "https://github.com/Flinesoft/HandySwift.git", from: "3.4.0"),
  ],
  targets: [
    .target(
      name: "LaserFocusKit",
      dependencies: [
        .product(name: "BetterCodable", package: "BetterCodable"),
        .product(name: "HandySwift", package: "HandySwift"),
      ]
    ),
    .testTarget(name: "LaserFocusKitTests", dependencies: ["LaserFocusKit"]),
  ]
)
