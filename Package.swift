// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "LaserFocus",
  products: [
    .library(name: "LaserFocus", targets: ["LaserFocus"]),
  ],
  dependencies: [
    // Handy Swift features that didn't make it into the Swift standard library.
    .package(url: "https://github.com/Flinesoft/HandySwift.git", .branch("main")),
  ],
  targets: [
    .target(
      name: "LaserFocus",
      dependencies: []
    ),
    .testTarget(name: "LaserFocusTests", dependencies: ["LaserFocus"]),
  ]
)
