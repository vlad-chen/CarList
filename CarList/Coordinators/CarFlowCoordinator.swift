//
//  CarFlowCoordinator.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class CarFlowCoordinator: Coordinator, ChildViewControllersCoordinator, Builder {
    
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
    fileprivate weak var carAddViewController: CarAddViewController?
    fileprivate weak var carDetailsViewController: CarDetailsViewController?
    
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
    
    func addCar() {
        carAddViewController = R.storyboard.car.carAddViewController()
        guard let carAddViewController = carAddViewController
            else { fatalError("Can't initialize car add view controller") }
        let service = CarAddService()
        buildModule(with: carAddViewController, provider: service)
        navigationController.pushViewController(carAddViewController, animated: true)
    }
    
    func showDetails() {
        carDetailsViewController = R.storyboard.car.carDetailsViewController()
        guard let carDetailsViewController = carDetailsViewController
            else { fatalError("Can't initialize car details view controller") }
        let service = CarDetailsService()
        buildModule(with: carDetailsViewController, provider: service)
        navigationController.pushViewController(carDetailsViewController, animated: true)
    }
    
    func embedWeatherInfo(in view: UIView) {
        weatherInfoViewController = R.storyboard.car.weatherInfoViewController()
        guard let weatherInfoViewController = weatherInfoViewController
            else { fatalError("Can't initialize weather info view controller") }
        guard let carListViewController = carListViewController
            else { fatalError("Can't find car list view controller") }
        let model = WeatherInfoModel(with: WeatherService(), locationProvider: LocationService())
        buildModule(with: weatherInfoViewController, model: model)
        move(weatherInfoViewController, to: carListViewController, in: view)
    }
    
}

extension CarFlowCoordinator: WeatherInfoCoordinator {}
extension CarFlowCoordinator: CarAddCoordinator {}
extension CarFlowCoordinator: CarDetailsCoordinator {}
