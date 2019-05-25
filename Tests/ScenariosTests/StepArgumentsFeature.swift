//  Copyright © 2015 Outware Mobile. All rights reserved.

import Nimble
import Scenarios

final class StepArgumentsFeature: Feature {
  override func scenarios() {

    Scenario("Single argument")
      .Given("I provide arguments [1:hello]")
      .Then("the first argument is hello")

    Scenario("Two arguments")
      .Given("I provide arguments [1:hello 2:world]")
      .Then("the first argument is hello")
      .And("the second argument is world")

    Scenario("Three arguments")
      .Given("I provide arguments [1:foo 2:bar 3:baz]")
      .Then("the first argument is foo")
      .And("the second argument is bar")
      .And("the third argument is baz")

  }
}

final class StepArgumentsSteps: StepDefinition {
  override func steps() {
    var capturedArgs: StepArguments!

    Given("I provide arguments \\[1:(\\S+)\\]") { args in
      capturedArgs = args
    }

    Given("I provide arguments \\[1:(\\S+) 2:(\\S+)\\]") { args in
      capturedArgs = args
    }

    Given("I provide arguments \\[1:(\\S+) 2:(\\S+) 3:(\\S+)\\]") { args in
      capturedArgs = args
    }

    Then("the (.+) argument is (.+)") { args in
      let (position, subject) = (args[0], args[1])

      let expected: String

      switch position {
      case "first":
        expected = capturedArgs[0]
      case "second":
        expected = capturedArgs[1]
      case "third":
        expected = capturedArgs[2]
      case "fourth":
        expected = capturedArgs[3]
      default:
        fail("couldn't find an argument at position \(position)")
        return
      }

      expect(subject).to(equal(expected))
    }
  }
}
