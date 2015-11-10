//  Copyright © 2015 Adam Sharp. All rights reserved.

class ViewController: UIViewController {

  @IBOutlet var nameField: UITextField!

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.destinationViewController {
    case let greetingVC as GreetingViewController:
      greetingVC.subject = nameField.text
    default:
      break
    }
  }

}

import UIKit
