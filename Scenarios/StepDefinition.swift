//  Copyright © 2015 Outware Mobile. All rights reserved.

public typealias StepDefinitionFunc = () -> ()

public class StepDefinition: QuickSpec {

  // MARK: Step definition API

  public func Given(description: String, definition: () -> ()) {
    registerStepWithDescription(description, definition: definition)
  }

  public func When(description: String, definition: () -> ()) {
    registerStepWithDescription(description, definition: definition)
  }

  public func Then(description: String, definition: () -> ()) {
    registerStepWithDescription(description, definition: definition)
  }

  // MARK: Matching step definitions

  internal static func lookup(description: String, forStepInFile filePath: String, atLine lineNumber: UInt) -> () -> StepDefinitionFunc? {
    let step = Step(name: description, inFile: filePath, atLine: lineNumber)

    return {
      guard let definition = stepDefinitions[description] else {
        return nil
      }

      return {
        executingStep = step
        definition()
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

  private func registerStepWithDescription(description: String, definition: () -> ()) {
    self.dynamicType.stepDefinitions[description] = definition
  }

  private static var stepDefinitions: [String: () -> ()] = [:]

}

import Quick
