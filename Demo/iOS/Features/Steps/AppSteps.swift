//  Copyright © 2015 Adam Sharp. All rights reserved.

final class AppSteps: StepDefinition {
  override func steps() {

    When("^the app has launched$") { _ in
      XCUIApplication().launch()
    }

  }
}

import Scenarios
import Nimble
import XCTest
