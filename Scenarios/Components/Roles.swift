//  Copyright © 2017 Outware Mobile. All rights reserved.

public protocol Extendable {

  func And(_ description: String, file: String, line: UInt) -> Self

}

public protocol Preparable {

  func Given(_ description: String, file: String, line: UInt) -> Prepared

}

public protocol Actionable {

  func When(_ description: String, file: String, line: UInt) -> Actioned

}

public protocol Assertable {

  func Then(_ description: String, file: String, line: UInt) -> Asserted
  
}

internal protocol ScenarioBuilder {

  mutating func add(stepWithDescription description: String, file: String, line: UInt)

}
