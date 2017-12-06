//
//  CarListViewModel.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CarListViewModel: ViewModel<CarListModel> {
    
    // MARK: - Public -
    var cars: Driver<[CarRepresentation]> {
        return model.cars.map { self.representation(for: $0) }
    }
    var title: Driver<String> = .just(Localizable.carListTitle())
    
    // MARK: - Private -
    private func representation(for cars: [Car]) -> [CarRepresentation] {
        return cars.map {
            let priceString = "$" + $0.price
            return CarRepresentation(name: $0.name,
                                     price: priceString)
        }
    }
    
}
