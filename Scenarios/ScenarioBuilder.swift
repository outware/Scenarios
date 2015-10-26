//  Copyright © 2015 Outware Mobile. All rights reserved.

internal protocol ScenarioBuilder {
  mutating func registerScenario(description: String, file: String, line: UInt)
}
