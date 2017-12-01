//
//  CarListViewController.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

class CarListViewController: View<CarListViewModel, CarListCoordinator> {
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.doSmth()
    }
    
    // MARK: - Private -
    
}
