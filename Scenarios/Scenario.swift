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
public final class Scenario: Preparable, Actionable, ScenarioBuilder {

  private let name: String
  private let file: String
  private let line: UInt
  private let commitFunc: CommitFunc
  private var stepDescriptions: [StepMetadata] = []

  public init(_ name: String, file: String = #file, line: UInt = #line, commit: @escaping CommitFunc = quick_it) {
    self.name = name
    self.file = file
    self.line = line
    self.commitFunc = commit
  }

  public func Given(_ description: String, file: String = #file, line: UInt = #line) -> Prepared {
    addStep(description, file: file, line: line)
    return Prepared(self)
  }

  public func When(_ description: String, file: String = #file, line: UInt = #line) -> Actioned {
    addStep(description, file: file, line: line)
    return Actioned(self)
  }

  deinit {
    let unresolvedSteps = stepDescriptions.map { metadata in
      { (metadata, StepDefinition.lookup(metadata.description, forStepInFile: metadata.file, atLine: metadata.line)) }
    }

    commit(name, file: file, line: line) {
      let result: ResolvedSteps = unresolvedSteps.reduce(.matchedActions([])) { result, lookup in
        switch result {
        case .missingStep:
          return result
        case var .matchedActions(actions):
          let (metadata, query) = lookup()
          if let action = query() {
            actions.append(action)
            return .matchedActions(actions)
          } else {
            return .missingStep(metadata)
          }
        }
      }

      switch result {
      case let .missingStep(metadata):
        XCTFail("couldn't match step description: '\(metadata.description)'", line: metadata.line)
      case let .matchedActions(actions):
        for action in actions {
          action()
        }
      }
    }
  }

  private func commit(_ description: String, file: String, line: UInt, closure: @escaping () -> Void) {
    commitFunc(description, file, line, closure)
  }

  internal func addStep(_ description: String, file: String, line: UInt) {
    stepDescriptions.append(description: description, file: file, line: line)
  }

}

public typealias CommitFunc = (String, String, UInt, @escaping () -> Void) -> Void

private let quick_it: CommitFunc = { description, file, line, closure in
  it(description, file: file, line: line, closure: closure)
}

private typealias StepMetadata = (description: String, file: String, line: UInt)

private enum ResolvedSteps {

  case missingStep(StepMetadata)
  case matchedActions([StepActionFunc])

}

import Quick
import XCTest
