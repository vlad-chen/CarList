//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    public class func showMessage(_ message: String, controller: UIViewController? = nil) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    (controller ?? UIViewController.topViewController())
        .present(alert, animated: true, completion: nil)
  }
}
