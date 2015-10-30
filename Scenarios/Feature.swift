//  Copyright © 2015 Outware Mobile. All rights reserved.

/// Subclass `Feature` and override `scenarios()` to define the steps for the
/// scenarios in your feature.
public class Feature: QuickSpec {
  override public func setUp() {
    super.setUp()
    continueAfterFailure = false
  }

  public override func tearDown() {
    super.tearDown()
    guard self.dynamicType != Feature.self else { return }
    XCUIApplication().terminate()
  }

  public func scenarios() {}

  override public func spec() {
    scenarios()
  }

  override public func recordFailureWithDescription(description: String, inFile filePath: String, atLine lineNumber: UInt, expected: Bool) {
    if let sourceLocation = StepDefinition.executingStep?.sourceLocation {
      super.recordFailureWithDescription(description, inFile: sourceLocation.filePath, atLine: sourceLocation.lineNumber, expected: expected)
    } else {
      super.recordFailureWithDescription(description, inFile: filePath, atLine: lineNumber, expected: expected)
    }
  }
}

import Quick
