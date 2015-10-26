//  Copyright © 2015 Outware Mobile. All rights reserved.

extension StepDefinition {
  func Given(description: String, definition: () -> ()) {
    registerStepWithDescription(description, definition: definition)
  }

  func Then(description: String, definition: () -> ()) {
    registerStepWithDescription(description, definition: definition)
  }
}
