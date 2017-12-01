//
//  CarFlowCoordinator.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class CarFlowCoordinator: Builder {
    
    // MARK: - Init -

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        setup()
    }
    
    // MARK: - Private -
    
    private let navigationController: UINavigationController
    
    private func setup() {
        guard let viewController = R.storyboard.car.carListViewController() else {
            fatalError("Can't initialize car list view controller")
        }
        let service = CarListService()
        buildModule(with: viewController, provider: service)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
}

extension CarFlowCoordinator: CarListCoordinator {
    func addCar() { }
    func showDetails() { }
}
