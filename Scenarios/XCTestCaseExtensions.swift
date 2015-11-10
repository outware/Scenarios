//  Copyright © 2015 Outware Mobile. All rights reserved.

extension XCTestCase {

  /// Determines whether we're running UI tests based on whether the target
  /// application is set. This is achieved by looking up the private API
  /// `+[XCTestConfiguration activeTestConfiguration]` and checking whether
  /// its `-targetApplicationPath` is nil.
  ///
  /// Credit to @modocache for mainting the excellent XCTest-Headers repo:
  /// https://github.com/modocache/XCTest-Headers/blob/master/XCTest.framework/iPhoneSimulator.platform/XCTestConfiguration.h
  ///
  /// It would be great if there was public API to check whether we're running
  /// UI tests. `-[XCUIApplication init]` already checks this internally and
  /// crashes, so it would be excellent to be able to do this safely.
  var isUITesting: Bool {
    let klass = NSClassFromString("XCTestConfiguration") as! AnyObject
    let configuration = klass.performSelector("activeTestConfiguration").takeUnretainedValue()
    return configuration.performSelector("targetApplicationPath") != nil
  }

}

import XCTest
