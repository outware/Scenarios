//  Copyright © 2015 Outware Mobile. All rights reserved.

// MARK: Roles

public protocol Extendable {
  func And(description: String, file: String, line: UInt) -> Self
}

public protocol Preparable {
  func Given(description: String, file: String, line: UInt) -> Prepared
}

public protocol Actionable {
  func When(description: String, file: String, line: UInt) -> Actioned
}

public protocol Assertable {
  func Then(description: String, file: String, line: UInt) -> Asserted
}

// MARK: Types

public final class Prepared: Assertable, Actionable, Extendable {
  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  public func And(description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.addStep(description, file: file, line: line)
    return self
  }

  public func When(description: String, file: String = #file, line: UInt = #line) -> Actioned {
    builder.addStep(description, file: file, line: line)
    return Actioned(builder)
  }

  public func Then(description: String, file: String = #file, line: UInt = #line) -> Asserted {
    builder.addStep(description, file: file, line: line)
    return Asserted(builder)
  }
}

public final class Actioned: Assertable, Extendable {
  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  public func And(description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.addStep(description, file: file, line: line)
    return self
  }

  public func Then(description: String, file: String = #file, line: UInt = #line) -> Asserted {
    builder.addStep(description, file: file, line: line)
    return Asserted(builder)
  }
}

public final class Asserted: Extendable {
  private var builder: ScenarioBuilder

  internal init(_ builder: ScenarioBuilder) {
    self.builder = builder
  }

  public func And(description: String, file: String = #file, line: UInt = #line) -> Self {
    builder.addStep(description, file: file, line: line)
    return self
  }
}
