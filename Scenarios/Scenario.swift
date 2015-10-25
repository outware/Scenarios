//  Copyright © 2015 Outware Mobile. All rights reserved.

/// Define a scenario by giving it a name and then adding steps, like so:
///
///     Scenario("Greeting on first load")
///       .Given("the app has launched")
///       .Then("the text 'Hello, world!' is displayed")
///
/// After the last step is defined, the scenario is compiled into a Quick example
/// block by looking up the step definitions based on the step names. The test
/// fails if any of the steps are undefined.
final class Scenario {
  private let name: String
  private var stepDescriptions: [String] = []

  init(_ name: String) {
    self.name = name
  }

  func Given(stepDescription: String) -> Self {
    stepDescriptions.append(stepDescription)
    return self
  }

  func Then(stepDescription: String) -> Self {
    stepDescriptions.append(stepDescription)
    return self
  }

  deinit {
    let description = stepDescriptions.joinWithSeparator(", ")
    let unresolvedSteps = stepDescriptions.map { description in
      { (description, StepDefinition.lookup(description)) }
    }

    it(description) {
      let result: ResolvedSteps = unresolvedSteps.reduce(.MatchedActions([])) { result, lookup in
        switch result {
        case .MissingStep:
          return result
        case var .MatchedActions(actions):
          let (description, query) = lookup()
          if let action = query() {
            actions.append(action)
            return .MatchedActions(actions)
          } else {
            return .MissingStep("step definition missing: \(description)")
          }
        }
      }

      switch result {
      case let .MissingStep(message):
        fail(message)
      case let .MatchedActions(actions):
        for action in actions {
          action()
        }
      }
    }
  }
}

private enum ResolvedSteps {
  case MissingStep(String)
  case MatchedActions([() -> ()])
}

import Quick
import Nimble
