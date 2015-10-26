//  Copyright © 2015 Outware Mobile. All rights reserved.

internal struct SourceLocation {
  var filePath: String
  var lineNumber: UInt
}

internal struct Step {
  let name: String
  let sourceLocation: SourceLocation

  init(name: String, inFile filePath: String, atLine lineNumber: UInt) {
    self.name = name
    self.sourceLocation = SourceLocation(filePath: filePath, lineNumber: lineNumber)
  }
}
