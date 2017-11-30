//
//  AppFlowCoordinator.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class AppFlowCoordinator {
    
    // MARK: - Singletone -

    static let shared = AppFlowCoordinator()
    private init() {}
    
    // MARK: - Public -

    func setup(with window: UIWindow) {
        let navigationController = UINavigationController()
        carFlowCoordinator = CarFlowCoordinator(with: navigationController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // MARK: - Private -

    private var window: UIWindow?
    private var carFlowCoordinator: CarFlowCoordinator?
    
}
