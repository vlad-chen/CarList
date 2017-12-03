//
//  AppFlowCoordinator.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class AppFlowCoordinator: Coordinator {
    
    // MARK: - Singletone -

    static let shared = AppFlowCoordinator()
    private init() {}
    
    // MARK: - Public -
    var topViewController: UIViewController {
        if activeCoordinator is AppFlowCoordinator {
            guard let window = window, let rootViewController = window.rootViewController
                else { fatalError("No window or root view controller")}
            return rootViewController
        } else {
            return activeCoordinator.topViewController            
        }
    }

    func setup(with window: UIWindow) {
        let navigationController = UINavigationController()
        let carFlowCoordinator = CarFlowCoordinator(with: navigationController)
        activeCoordinator = carFlowCoordinator
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // MARK: - Private -
    private var window: UIWindow?
    private lazy var activeCoordinator: Coordinator = self
    
}
