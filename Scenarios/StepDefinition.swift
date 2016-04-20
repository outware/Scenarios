//  Copyright © 2015 Outware Mobile. All rights reserved.

public typealias StepDefinitionFunc = StepArguments -> ()
internal typealias StepActionFunc = () -> ()

public class StepDefinition: QuickSpec {

  // MARK: Step definition API

  public func Given(pattern: String, definition: StepDefinitionFunc) {
    registerStepWithPattern(pattern, definition: definition)
  }

  public func When(pattern: String, definition: StepDefinitionFunc) {
    registerStepWithPattern(pattern, definition: definition)
  }

  public func Then(pattern: String, definition: StepDefinitionFunc) {
    registerStepWithPattern(pattern, definition: definition)
  }

  // MARK: Matching step definitions

  internal static func lookup(description: String, forStepInFile filePath: String, atLine lineNumber: UInt) -> () -> StepActionFunc? {
    let step = Step(name: description, inFile: filePath, atLine: lineNumber)

    return {
      guard let (args, definition) = stepDefinitions.lazy
        .flatMap({ pattern, function in
          pattern.match(description).map {
            (StepArguments($0), function)
          }
        })
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

  public func steps() {}

  public override func spec() {
    super.spec()
    steps()
  }

  // MARK: Currently executing step

  internal private(set) static var executingStep: Step?

  // MARK: Registering step definitions

  private func registerStepWithPattern(pattern: String, definition: StepDefinitionFunc) {
    self.dynamicType.stepDefinitions.append(regexForPattern(pattern), definition)
  }

  private func regexForPattern(pattern: String) -> Regex {
    var mutablePattern = pattern
    if !mutablePattern.hasPrefix("^") { mutablePattern.insert("^", atIndex: mutablePattern.startIndex) }
    if !mutablePattern.hasSuffix("$") { mutablePattern.insert("$", atIndex: mutablePattern.endIndex) }
    return Regex(mutablePattern)
  }

  private static var stepDefinitions: [(Regex, StepDefinitionFunc)] = []

}

import Quick
import Regex
