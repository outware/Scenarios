//  Copyright © 2017 Outware Mobile. All rights reserved.

/// A scenario that has had its preconditions prepared, and is ready to have its
/// state acted upon, or to have state that is a result of preparing its _preconditions_
/// asserted.
///
/// - note: A scenario is generally `Prepared` as a result of a `Given` step, followed
///         by zero or more `And` steps.
///
/// e.g.
///
/// - __Given__ the user is on the Home Screen
/// - __And__ the currently logged-in account is a Type A account
/// - ...
///
/// This scenario performs steps to take the user to the home screen and manipulates
/// setup information such that their logged-in account is a "Type A" account.
///
/// At this stage, the scenario is `Prepared` to:
/// - have some state on the screen (such as the title of the screen) be asserted.
/// - be manipulated / acted upon (for example, by tapping on a button, or scrolling down
///     a list), in preparation for future state assertion.
public final class Prepared: Assertable, Actionable, Extendable {

  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  public func And(_ description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.add(stepWithDescription: description, file: file, line: line)
    return self
  }

  public func When(_ description: String, file: String = #file, line: UInt = #line) -> Actioned {
    builder.add(stepWithDescription: description, file: file, line: line)
    return Actioned(builder)
  }

  @discardableResult
  public func Then(_ description: String, file: String = #file, line: UInt = #line) -> Asserted {
    builder.add(stepWithDescription: description, file: file, line: line)
    return Asserted(builder)
  }

}

public final class Actioned: Assertable, Extendable {

  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  public func And(_ description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.add(stepWithDescription: description, file: file, line: line)
    return self
  }

  @discardableResult
  public func Then(_ description: String, file: String = #file, line: UInt = #line) -> Asserted {
    builder.add(stepWithDescription: description, file: file, line: line)
    return Asserted(builder)
  }

}

public final class Asserted: Extendable {

  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  @discardableResult
  public func And(_ description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.add(stepWithDescription: description, file: file, line: line)
    return self
  }

}
