//  Copyright © 2015 Outware Mobile. All rights reserved.

/// Subclass `Feature` and override `scenarios()` to define the steps for the
/// scenarios in your feature.
class Feature: QuickSpec {
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
  }

  func scenarios() {}

  override func spec() {
    scenarios()
  }

  override func recordFailureWithDescription(description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
    if let sourceLocation = StepDefinition.executingStep()?.sourceLocation {
      super.recordFailureWithDescription(description, inFile: sourceLocation.filePath, atLine: sourceLocation.lineNumber, expected: expected)
    } else {
      super.recordFailureWithDescription(description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
  }
}

import Quick
