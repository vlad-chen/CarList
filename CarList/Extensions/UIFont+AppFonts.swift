//
// Created by Vladimir Kravchenko on 3/20/16.
// Copyright (c) 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

  public class func mainFont() -> UIFont {
    return regularTextFont()
  }

  public class func mediumTextFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIText-Medium", size: CGFloat(size))!
  }

  public class func mediumDisplayFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIDisplay-Medium", size: CGFloat(size))!
  }

  public class func regularTextFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIText-Regular", size: CGFloat(size))!
  }

  public class func regularDisplayFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIDisplay-Regular", size: CGFloat(size))!
  }

  public class func lightTextFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIText-Light", size: CGFloat(size))!
  }

  public class func lightDisplayFont(withSize size: Double = 15.0) -> UIFont {
    return UIFont(name: "SFUIDisplay-Light", size: CGFloat(size))!
  }

}