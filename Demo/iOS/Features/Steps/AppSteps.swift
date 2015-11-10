//  Copyright © 2015 Adam Sharp. All rights reserved.

final class AppSteps: StepDefinition {
  override func steps() {

    Given("^the app has launched$") { args in
      XCUIApplication().launch()
    }

  }
}

import Scenarios
import Nimble
import XCTest
