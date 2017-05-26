//  Copyright © 2017 Outware Mobile. All rights reserved.

/// Scenarios which are being built whose most recent declaration can be extended.
///
/// e.g.
/// - Arranging (Preparing):
///     Arranging pre-conditions for scenarios can be extended by doing further setup.
/// - Acting:
///     Acting on scenarios can be extended by doing further manipulation of
///     model objects / user interface, for example.
/// - Asserting: 
///     Asserting results for scenarios can be extended by asserting multiple results.
public protocol Extendable {

  /// Specifies an extension to the most recent declaration of the scenario.
  ///
  /// - parameters:
  ///     - description: The specification to add to the scenario.
  ///
  /// - returns: A scenario which captures all specifications in the previous scenario
  ///            as well as the new specification.
  func And(_ description: String, file: String, line: UInt) -> Self

}


/// Scenarios which have yet to have any specification as to how they should be
/// prepared / how the conditions for the scenario should be __arranged__.
public protocol Preparable {

  /// Specifies the preparation / arrangement step for the scenario.
  ///
  /// - parameters:
  ///     - description: A specification detailing how the scenario should be prepared.
  ///
  /// - returns: A scenario which has had some preparation / arranging done.
  ///
  /// - seealso: Extendable
  func Given(_ description: String, file: String, line: UInt) -> Prepared

}


/// Scenarios for which the steps to carry out the tests which they capture have not
/// yet been specified.
public protocol Actionable {

  /// Specifies the action step for the scenario.
  ///
  /// - parameters:
  ///     - description: A specification detailing how the scenario should be acted upon.
  ///
  /// - returns: A scenario which has had some action performed.
  ///
  /// - seealso: Extendable
  func When(_ description: String, file: String, line: UInt) -> Actioned

}


/// Scenarios which have had some action / manipulation performed, and are ready to have
/// results be asserted.
public protocol Assertable {

  /// Specifies the assertion step for the scenario.
  ///
  /// - parameters:
  ///     - description: A specification detailing how the scenario's should have its
  ///                    state be confirmed.
  ///
  /// - seealso: Extendable
  func Then(_ description: String, file: String, line: UInt) -> Asserted
  
}


/// Instances of conforming types are able to build scenarios by collecting multiple
/// components (types which are `Preparable`, `Actionable`, `Assertable`) as they are
/// built-up, and commiting the result to the test harness.
internal protocol ScenarioBuilder {

  /// Adds a specification to the scenario to-be-built.
  ///
  /// - note: Agnostic to the current stage of the built-up scenario.
  ///
  /// - parameters:
  ///     - description: A specification detailing the steps to be appended to the
  ///                    current state of the scenario.
  mutating func add(stepWithDescription description: String, file: String, line: UInt)

}
