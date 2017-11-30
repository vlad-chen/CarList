//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  public class func topViewController() -> UIViewController {
    return UIApplication.shared.keyWindow!.rootViewController!
  }
}
