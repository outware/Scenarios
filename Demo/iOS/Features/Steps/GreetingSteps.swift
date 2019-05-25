//  Copyright © 2015 Adam Sharp. All rights reserved.

import Nimble
import Scenarios
import XCTest

final class GreetingSteps: StepDefinition {
  override func steps() {

    Then("^the greeting '(.+)' should be on screen$") { args in
      expect(XCUIApplication().staticTexts[args[0]].exists).toEventually(beTrue())
    }

    When("^I enter '(.+)' as my name$") { args in
      let app = XCUIApplication()

      let textField = app.textFields["enter_name"]
      textField.tap()

      let name = args[0]
      textField.typeText(name)

      let nextButton = app.buttons["Done"]
      nextButton.tap()
    }

    Then("^I should see the greeting '(.+)' on screen$") { args in
      let app = XCUIApplication()
      let greeting = args[0]
      let label = app.staticTexts[greeting]
      expect(label.exists).to(beTrue(), description: "expected to see greeting '\(greeting)'")
    }

  }
}
