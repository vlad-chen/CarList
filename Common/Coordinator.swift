//
//  Coordinator.swift
//  CarList
//
//  Created by Vlad Che on 12/3/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

protocol Coordinator {
    var topViewController: UIViewController {get}
}

protocol ChildViewControllersCoordinator {
    func move(_ child: UIViewController, to parent: UIViewController, in view: UIView)
    func remove(_ child: UIViewController)
    func transit(from old: UIViewController, to new: UIViewController)
}

extension ChildViewControllersCoordinator {
    
    func move(_ child: UIViewController, to parent: UIViewController, in view: UIView) {
        parent.addChildViewController(child)
        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParentViewController: parent)
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParentViewController: nil)
        child.view.removeFromSuperview()
        child.removeFromParentViewController()
    }
    
    func transit(from old: UIViewController, to new: UIViewController) {
        guard let parent = old.parent else {
            fatalError("No parent view controller")
        }
        old.willMove(toParentViewController: nil)
        parent.addChildViewController(new)
        new.view.frame = old.view.frame.applying(CGAffineTransform.init(translationX: old.view.frame.width, y: 0))
        let oldViewEndFrame = old.view.frame.applying(CGAffineTransform.init(translationX: -old.view.frame.width, y: 0))
        parent.transition(from: old,
                          to: new,
                          duration: 0.25,
                          options: UIViewAnimationOptions.curveLinear,
                          animations: {
                            new.view.frame = old.view.frame
                            old.view.frame = oldViewEndFrame
        },
                          completion: { finished in
                            old.removeFromParentViewController()
                            new.didMove(toParentViewController: parent)
        })
    }
    
}
