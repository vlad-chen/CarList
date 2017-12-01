//
//  CarListProtocols.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation

protocol CarListProvider {
    
}

protocol CarListCoordinator {
    func addCar()
    func showDetails()
}

protocol CarListViewModelProtocol { }

protocol CarListModelProtocol { }
