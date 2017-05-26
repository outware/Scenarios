//  Copyright © 2017 Outware Mobile. All rights reserved.

/// A scenario that has had its preconditions prepared and is ready to:
/// - have its state acted upon, or
/// - have its prepared state asserted.
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
/// - have some state on the screen (such as the title of the screen) be asserted, or
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


/// A scenario that has had some intermediate action(s) performed (it has had preconditions
/// prepared, and its test steps, the actions, performed), and is ready to have its
/// state be asserted.
///
/// - note: A scenario is generally `Actioned` as a result of a `When` step, followed
///         by zero or more `And` steps.
///
/// e.g.
///
/// - __Given__ the user is on the Home Screen
/// - __When__ the user taps the 'Edit' Button
/// - ...
///
/// This scenario performs steps to take the user to the home screen as part of its
/// 'arrange' steps (setting up its preconditions). It then performs the intermediate
/// action(s) which is being tested (in this case, tapping on the edit button).
///
/// At this stage, the scenario has had its test case `Actioned`, and is ready to 
/// have its (new) state be asserted.
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


/// A scenario that has had its state, post-test-case-execution, asserted.
///
/// - note: A scenario is generally `Asserted` as a result of a `Then` step, followed
///         by zero or more `And` steps.
///
/// e.g.
///
/// - __Given__ the user is on the Home Screen
/// - __When__ the user taps the 'Edit' Button
/// - __Then__ the user is taken to the Edit Items Screen
///
/// This scenario performs steps to take the user to the home screen as part of its
/// 'arrange' steps (setting up its preconditions). It then performs the intermediate
/// action(s) which is being tested (in this case, tapping on the edit button). Finally,
/// it 'assert's that the user is taken to the Edit Items screen (the semantics of
/// determining that is up to the implementers).
///
/// - __Given__ the user is on the Home Screen
/// - __Then__ the title of the screen is 'Home'
///
/// Similarly, this scenario performs steps to take the user to the home screen, if it
/// is not the default screen displayed. It then 'assert's that the title of the screen
/// is "Home".
///
/// At this stage, the scenario has `Asserted` its expectations of the results of
/// the test case execution and is ready to be built.
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
