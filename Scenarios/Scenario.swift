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
public final class Scenario: Preparable {
  private let name: String
  private var stepDescriptions: [StepMetadata] = []

  public init(_ name: String) {
    self.name = name
  }

  public func Given(description: String, file: String = __FILE__, line: UInt = __LINE__) -> Prepared {
    registerScenario(description, file: file, line: line)
    return Prepared(self)
  }

  deinit {
    let description = stepDescriptions.map { $0.description }.joinWithSeparator(", ")
    let unresolvedSteps = stepDescriptions.map { metadata in
      { (metadata, StepDefinition.lookup(metadata.description, forStepInFile: metadata.file, atLine: metadata.line)) }
    }

    it(description) {
      let result: ResolvedSteps = unresolvedSteps.reduce(.MatchedActions([])) { result, lookup in
        switch result {
        case .MissingStep:
          return result
        case var .MatchedActions(actions):
          let (metadata, query) = lookup()
          if let action = query() {
            actions.append(action)
            return .MatchedActions(actions)
          } else {
            return .MissingStep(metadata)
          }
        }
      }

      switch result {
      case let .MissingStep(metadata):
        fail("couldn't match step description: '\(metadata.description)'", file: metadata.file, line: metadata.line)
      case let .MatchedActions(actions):
        for action in actions {
          action()
        }
      }
    }
  }
}

extension Scenario: ScenarioBuilder {
  func registerScenario(description: String, file: String, line: UInt) {
    stepDescriptions.append(description: description, file: file, line: line)
  }
}

private typealias StepMetadata = (description: String, file: String, line: UInt)

private enum ResolvedSteps {
  case MissingStep(StepMetadata)
  case MatchedActions([() -> ()])
}

import Quick
import Nimble
