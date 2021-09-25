// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "LaserFocus",
  platforms: [.macOS(.v10_12)],
  products: [
    .library(name: "LaserFocus", targets: ["LaserFocus"]),
  ],
  dependencies: [
    // Better Codable through Property Wrappers
    .package(url: "https://github.com/marksands/BetterCodable.git", from: "0.4.0"),

    // Handy Swift features that didn't make it into the Swift standard library.
    .package(url: "https://github.com/Flinesoft/HandySwift.git", .branch("main")),
  ],
  targets: [
    .target(
      name: "LaserFocus",
      dependencies: [
        .product(name: "BetterCodable", package: "BetterCodable"),
        .product(name: "HandySwift", package: "HandySwift"),
      ]
    ),
    .testTarget(name: "LaserFocusTests", dependencies: ["LaserFocus"]),
  ]
)
