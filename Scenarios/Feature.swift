//  Copyright © 2015 Outware Mobile. All rights reserved.

/// Subclass `Feature` and override `scenarios()` to define the steps for the
/// scenarios in your feature.
open class Feature: QuickSpec {

  override open func setUp() {
    super.setUp()
    continueAfterFailure = false
  }

  open func scenarios() {}

  override open func spec() {
    scenarios()
  }

  override open func recordFailure(withDescription description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
    if let sourceLocation = StepDefinition.executingStep?.sourceLocation {
      super.recordFailure(withDescription: description, inFile: sourceLocation.filePath, atLine: sourceLocation.lineNumber, expected: expected)
    } else {
      super.recordFailure(withDescription: description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
  }

}

import Quick
