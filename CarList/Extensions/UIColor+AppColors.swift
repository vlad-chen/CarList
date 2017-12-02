//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var background: UIColor { return #colorLiteral(red: 0.6000440717, green: 0.7897123694, blue: 0.2467174828, alpha: 1) }
    class var tint: UIColor { return #colorLiteral(red: 0.9999085069, green: 1, blue: 0.9998822808, alpha: 1) }
    class var text: UIColor { return #colorLiteral(red: 0.9999085069, green: 1, blue: 0.9998822808, alpha: 1) }

    class func colorFromHex(_ hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }

}
