//
//  AppDelegate.swift
//  CarList
//
//  Created by Vlad Che on 11/26/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate { /* MARK: UIApplicationDelegate \*/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        AppFlowCoordinator.shared.setup(with: window)
        return true
    }
}

