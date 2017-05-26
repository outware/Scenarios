//  Copyright © 2015 Outware Mobile. All rights reserved.

final class ScenarioSpec: QuickSpec {
  override func spec() {

    describe("Scenario") {

      describe("generated test name") {
        it("is the same as the name of the scenario") {
          var capturedName: String?

          let commitFunction: CommitFunc = { (description: String, _, _, _) -> Void in
            capturedName = description
          }

          _ = Scenario("a new scenario", commit: commitFunction)

          expect(capturedName).to(equal("a new scenario"))
        }

        it("doesn't include any step names") {
          var capturedName: String?

          let commitFunction: CommitFunc = { (description: String, _, _, _) -> Void in
            capturedName = description
          }

          _ = Scenario("a new scenario", commit: commitFunction)
            .Given("a single step")

          expect(capturedName).to(equal("a new scenario"))
        }
      }

    }

  }
}

import Quick
import Nimble
import Scenarios
