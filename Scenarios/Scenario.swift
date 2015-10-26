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
public final class Scenario {
  private let name: String
  private var stepDescriptions: [StepMetadata] = []

  public init(_ name: String) {
    self.name = name
  }

  public func Given(stepDescription: String, inFile filePath: String = __FILE__, atLine lineNumber: UInt = __LINE__) -> Self {
    stepDescriptions.append(description: stepDescription, filePath: filePath, lineNumber: lineNumber)
    return self
  }

  public func Then(stepDescription: String, inFile filePath: String = __FILE__, atLine lineNumber: UInt = __LINE__) -> Self {
    stepDescriptions.append(description: stepDescription, filePath: filePath, lineNumber: lineNumber)
    return self
  }

  deinit {
    let description = stepDescriptions.map { $0.1 }.joinWithSeparator(", ")
    let unresolvedSteps = stepDescriptions.map { metadata in
      { (metadata, StepDefinition.lookup(metadata.description, forStepInFile: metadata.filePath, atLine: metadata.lineNumber)) }
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
        fail("couldn't match step description: '\(metadata.description)'", file: metadata.filePath, line: metadata.lineNumber)
      case let .MatchedActions(actions):
        for action in actions {
          action()
        }
      }
    }
  }
}

private typealias StepMetadata = (description: String, filePath: String, lineNumber: UInt)

private enum ResolvedSteps {
  case MissingStep(StepMetadata)
  case MatchedActions([() -> ()])
}

import Quick
import Nimble
