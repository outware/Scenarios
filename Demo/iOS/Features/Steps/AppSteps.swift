//  Copyright © 2015 Adam Sharp. All rights reserved.

import Nimble
import Scenarios
import XCTest

final class AppSteps: StepDefinition {
  override func steps() {

    When("^the app has launched$") { _ in
      XCUIApplication().launch()
    }

  }
}
