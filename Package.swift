// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "Scenarios",
  dependencies: [
    .package(url: "https://github.com/sharplet/Regex.git", from: "1.0.0"),
    .package(url: "https://github.com/Quick/Quick.git", from: "1.0.0"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "7.0.0"),
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
  swiftLanguageVersions: [3, 4]
)
