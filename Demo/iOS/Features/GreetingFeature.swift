//  Copyright © 2015 Adam Sharp. All rights reserved.

final class GreetingFeature: Feature {
  override func scenarios() {

    // In order to keep users coming back
    // As a developer
    // I want to greet them warmly when returning to the app

    Scenario("Greeting on launch")
      .When("the app has launched")
      .Then("the greeting 'Hello, world!' should be on screen")

    Scenario("Personalised greeting")
      .Given("the app has launched")
      .When("I enter 'Friend' as my name")
      .Then("I should see the greeting 'Hello, Friend!' on screen")

  }
}

import Scenarios
