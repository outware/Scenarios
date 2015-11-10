//  Copyright © 2015 Adam Sharp. All rights reserved.

final class GreetingViewController: UIViewController {

  @IBOutlet var greetingLabel: UILabel!

  var subject: String?

  var greeting: String? {
    return subject.map { "Hello, \($0)!" }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    greetingLabel.text = greeting
  }

}

import UIKit
