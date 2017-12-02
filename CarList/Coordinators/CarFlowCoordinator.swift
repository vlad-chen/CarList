//
//  CarFlowCoordinator.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class CarFlowCoordinator: Coordinator, Builder {
    
    // MARK: - Public -
    private(set) unowned var topViewController: UIViewController
    
    // MARK: - Init -

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        topViewController = navigationController
        setup()
    }
    
    // MARK: - Private -
    
    fileprivate unowned let navigationController: UINavigationController
    fileprivate weak var carListViewController: CarListViewController?
    fileprivate weak var weatherInfoViewController: WeatherInfoViewController?
    
    private func setup() {
        guard let carListViewController = R.storyboard.car.carListViewController()
            else { fatalError("Can't initialize car list view controller") }
        self.carListViewController = carListViewController
        let service = CarListService()
        buildModule(with: carListViewController, provider: service)
        navigationController.setViewControllers([carListViewController], animated: false)
        topViewController = carListViewController
    }
    
}

extension CarFlowCoordinator: CarListCoordinator {
    
    func addCar() { }
    
    func showDetails() { }
    
    func embedWeatherInfo(in view: UIView) {
        weatherInfoViewController = R.storyboard.car.weatherInfoViewController()
        guard let weatherInfoViewController = weatherInfoViewController
            else { fatalError("Can't initialize weather info view controller") }
        let service = WeatherService()
        buildModule(with: weatherInfoViewController, provider: service)
        
    }
    
}
