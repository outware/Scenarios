// swift-tools-version:3.1

import Foundation
import PackageDescription

var isTesting: Bool {
  let environment = ProcessInfo.processInfo.environment
  guard let value = environment["SCENARIOS_SWIFTPM_TEST"] else { return false }
  return NSString(string: value).boolValue
}

var package = Package(
  name: "Scenarios",
  targets: [
    Target(name: "Scenarios"),
  ],
  dependencies: [
    .Package(url: "https://github.com/Quick/Quick.git", majorVersion: 1),
    .Package(url: "https://github.com/sharplet/Regex.git", majorVersion: 1),
  ],
  swiftLanguageVersions: [3, 4],
  exclude: [
    "Carthage",
    "Demo",
  ]
)

if isTesting {
  package.dependencies.append(contentsOf: [
    .Package(url: "https://github.com/Quick/Nimble.git", majorVersion: 7),
  ])
}
