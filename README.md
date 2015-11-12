# Scenarios

_Human-oriented testing in Swift._

## Introduction

Scenarios is a lightweight wrapper around [Quick][] for writing acceptance tests in BDD style. It's modelled after [Cucumber][].

```swift
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
```

[Quick]: https://github.com/Quick/Quick
[Cucumber]: http://cucumber.io/

When paired with Xcode UI Testing, Scenarios gives you a high-level, user-focused and very expressive way to describe the functionality of your app. Or you can use it to define acceptance tests for your library or framework.

Scenarios isn't a UI testing tool. It's a tool for _organising thought_.

## Getting Started

#### Install

You can install Scenarios as a dynamic framework via [Carthage][]. Just add this to your `Cartfile`:

```
github "outware/Scenarios"
```

Then run `carthage update`, and integrate `Scenarios.framework`, `Regex.framework` and `Quick.framework` into your test bundle. You can find a handy guide for this [in the Carthage README][Integration Guide].

[Carthage]: https://github.com/Carthage/Carthage
[Integration Guide]: https://github.com/Carthage/Carthage#adding-frameworks-to-unit-tests-or-a-framework

#### Your first feature

Let's use the example above to demonstrate how to test with Scenarios.

Inside your test bundle, create a file called `GreetingFeature.swift`. Delete any Xcode-generated boilerplate and paste in the following (feel free to delete the numbered comments):

```swift
// (1) Feature name
final class GreetingFeature: Feature {
  override func scenarios() {

    // (2) Feature story

    // In order to keep users coming back
    // As a developer
    // I want to greet them warmly when returning to the app

    // (3) A scenario

    Scenario("Greeting on launch")
      .When("the app has launched")
      .Then("the greeting 'Hello, world!' should be on screen")

  }
}
```

A feature explains a self-contained unit of functionality in your system. One way of thinking of this is a _user story_. There are a few parts that every feature should have:

1. A feature name. Be brief, and give a high-level name that will remind you or your team what the feature is about. By convention, the feature name should end with "Feature".
2. A few lines that introduce the feature, state who it is for, and describe the value. This isn't required (it's just a comment), but it's recommended, as it will help you to focus on the value of the feature long before getting bogged down in implementation details or code.
3. One or more scenarios. A scenario has a name (which maps directly to a Quick _example description_), and a list of steps. Steps all begin with the words _Given_, _When_, _Then_ or _And_. 

Hit Cmd-U in Xcode, and you should see a failing test — these is because the steps aren't implemented yet!

#### Given, When, Then

There's no functional difference between the words — the purpose is to help you break down your scenario.

**Given** steps describe the background to your feature. This is everything that needs to happen _before_ invoking the interesting functionality in this scenario. You can perform multiple steps with **And**.

**When** steps describe the actual action that a user should take to use your feature. It's recommended that each scenario have only a single **When** step, though there's nothing stopping you from using **And** here too. Seriously though, do try and keep this bit brief and to the point — it will only help your tests!

**Then** steps describe the result of the user's action. Here you can make an assertion about the return value or what is displayed on the screen, or whatever else might have happened as  a result of the user's action.

#### Implementing the steps, and seeing the test pass

Now we can implement the steps. Create a new group called `Steps` inside your tests group in Xcode. Now create a file inside called `GreetingSteps.swift`. Let's provide empty implementations for the steps:

```swift
final class GreetingSteps: StepDefinition {
  override func steps() {

    When("^the app has launched$") { _ in
      XCUIApplication().launch()
    }

    Then("^the greeting '(.+)' should be on screen$") { args in
      let app = XCUIApplication()
      let label = app.staticTexts[args[0]]
      XCTAssertTrue(label.exists)
    }

  }
}
```

Steps are defined using regular expressions. Any capture groups in your pattern are conveniently extracted for you and made accessible via the `args` parameter.

Now run the tests, this time they're likely to fail because nobody bothered put "Hello, world!" on the screen! Making the test green is now up to you.

## About Scenarios

Scenarios is still very much a proof of concept. The concept? That writing high-level tests in a Cucumber style can be delightful, and being able to keep everything integrated inside Xcode is super valuable for your workflow. It's designed to be as lightweight as possible on top of what you're already used to if you use Quick for testing.

However, it's totally ready for you to use! Please try it out and provide your feedback via GitHub issues.

If you'd like to contribute, Pull Requests are also most welcome!

## License

Scenarios is licensed under the Apache 2.0 License. See [LICENSE.txt](LICENSE.txt) for details.
