//
//  CarListProtocols.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CarListProvider {
    
}

protocol CarListCoordinator {
    func addCar()
    func showDetails()
    func embedWeatherInfo(in view: UIView)
}
