//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

  public class func colorFromHex(_ hex: Int, alpha: Double = 1.0) -> UIColor {
    let red = Double((hex & 0xFF0000) >> 16) / 255.0
    let green = Double((hex & 0xFF00) >> 8) / 255.0
    let blue = Double((hex & 0xFF)) / 255.0
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
  }

  public class func tintColor() -> UIColor {
    return colorFromHex(0x00a2ff)
  }

  public class func textColor() -> UIColor {
    return colorFromHex(0x1A1A1A)
  }

  public class func placeholderTextColor() -> UIColor {
    return colorFromHex(0x1A1A1A, alpha: 0.4)
  }

  public class func borderColor() -> UIColor {
    return colorFromHex(0xDDDDDD, alpha: 0.7)
  }

}
