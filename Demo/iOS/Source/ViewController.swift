//  Copyright © 2015 Adam Sharp. All rights reserved.

import UIKit

class ViewController: UIViewController {
  @IBOutlet var nameField: UITextField!

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.destination {
    case let greetingVC as GreetingViewController:
      greetingVC.subject = nameField.text
    default:
      break
    }
  }
}
