//  Copyright © 2015 Outware Mobile. All rights reserved.

public struct StepArguments: Collection {

  public let startIndex: Int = 0
  public var endIndex: Int { return captures.endIndex }

  private let captures: [String]

  internal init(_ matchResult: MatchResult) {
    self.captures = matchResult.captures.compactMap { $0 }
  }

  public subscript(index: Int) -> String {
    return captures[index]
  }

  public func index(after i: Int) -> Int {
    return captures.index(after: i)
  }

}

import Regex
