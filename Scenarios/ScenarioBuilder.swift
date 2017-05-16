//  Copyright © 2015 Outware Mobile. All rights reserved.

internal protocol ScenarioBuilder {
  mutating func addStep(_ description: String, file: String, line: UInt)
}
