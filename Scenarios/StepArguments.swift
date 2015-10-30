//  Copyright © 2015 Outware Mobile. All rights reserved.

public struct StepArguments: Indexable {

  public let startIndex: Int = 0
  public var endIndex: Int { return captures.endIndex }

  private let captures: [String]

  internal init(_ matchResult: MatchResult) {
    self.captures = matchResult.captures
  }

  public subscript(index: Int) -> String {
    return captures[index]
  }

}

import Regex
