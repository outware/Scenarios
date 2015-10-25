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
}

import Quick
