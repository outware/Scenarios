//  Copyright © 2015 Adam Sharp. All rights reserved.

import UIKit

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
