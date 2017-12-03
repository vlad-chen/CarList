//
//  CarListViewController.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class CarListViewController: View<CarListViewModel, CarListCoordinator> {
    
    // MARK: - IBOutlet -

    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction -

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        coordinator.addCar()
    }
    
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator.embedWeatherInfo(in: weatherView)
    }
    
    // MARK: - Private -
    
}
