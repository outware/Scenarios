// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "Scenarios",
  products: [
    .library(name: "Scenarios", targets: ["Scenarios"]),
  ],
  dependencies: [
    .package(url: "https://github.com/sharplet/Regex.git", from: "2.0.0"),
    .package(url: "https://github.com/Quick/Quick.git", from: "2.0.0"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"),
  ],
  targets: [
    .target(
      name: "Scenarios",
      dependencies: [
        "Quick",
        "Regex",
      ],
      path: "Scenarios"
    ),
    .testTarget(
      name: "ScenariosTests",
      dependencies: [
        "Scenarios",
        "Nimble",
      ],
      path: "Tests"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
