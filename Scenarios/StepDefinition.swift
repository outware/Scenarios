//  Copyright © 2015 Outware Mobile. All rights reserved.

public typealias StepDefinitionFunc = (StepArguments) -> Void
internal typealias StepActionFunc = () -> Void

open class StepDefinition: QuickSpec {

  private typealias UnmatchedStep = (pattern: Regex, function: StepDefinitionFunc)
  private typealias MatchedStep = (arguments: StepArguments, function: StepDefinitionFunc)

  // MARK: Step definition API

  open func Given(_ pattern: String, definition: @escaping StepDefinitionFunc) {
    registerStep(withPattern: pattern, definition: definition)
  }

  open func When(_ pattern: String, definition: @escaping StepDefinitionFunc) {
    registerStep(withPattern: pattern, definition: definition)
  }

  open func Then(_ pattern: String, definition: @escaping StepDefinitionFunc) {
    registerStep(withPattern: pattern, definition: definition)
  }

  // MARK: Matching step definitions

  internal static func lookup(_ description: String, forStepInFile filePath: StaticString, atLine lineNumber: UInt) -> () -> StepActionFunc? {

    let step = Step(name: description, inFile: filePath, atLine: lineNumber)

    func matchingStep(_ step: UnmatchedStep) -> MatchedStep? {
      return step.pattern.firstMatch(in: description).map {
        MatchedStep(arguments: StepArguments($0), function: step.function)
      }
    }

    return {
      guard let (args, definition) = stepDefinitions.lazy
        .flatMap(matchingStep)
        .first
      else { return nil }

      return {
        executingStep = step
        definition(args)
        executingStep = nil
      }
    }

  }

  // MARK: Step definition hook

  open func steps() { }

  open override func spec() {
    super.spec()
    steps()
  }

  // MARK: Currently executing step

  internal private(set) static var executingStep: Step?

  // MARK: Registering step definitions

  private func registerStep(withPattern pattern: String, definition: @escaping StepDefinitionFunc) {
    let step = UnmatchedStep(pattern: regex(forPattern: pattern), function: definition)
    type(of: self).stepDefinitions.append(step)
  }

  private func regex(forPattern pattern: String) -> Regex {
    var pattern: String = pattern
    if !pattern.hasPrefix("^") { pattern.insert("^", at: pattern.startIndex) }
    if !pattern.hasSuffix("$") { pattern.insert("$", at: pattern.endIndex) }
    do {
      return try Regex(string: pattern)
    } catch {
      preconditionFailure("unexpected error creating regex: \(error)")
    }
  }

  private static var stepDefinitions: [UnmatchedStep] = []

}

import Quick
import Regex
