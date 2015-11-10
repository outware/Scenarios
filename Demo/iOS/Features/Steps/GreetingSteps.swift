//  Copyright © 2015 Adam Sharp. All rights reserved.

final class GreetingSteps: StepDefinition {
  override func steps() {

    Then("^the greeting '(.+)' should be on screen$") { args in
      expect(XCUIApplication().staticTexts[args[0]].exists).toEventually(beTrue())
    }

  }
}

import Scenarios
import Nimble
import XCTest
