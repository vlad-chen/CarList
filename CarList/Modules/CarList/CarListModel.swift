//
//  CarListModel.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CarListModel: Model<CarListProvider> {
    
    // MARK: - Public -
    lazy var cars: Driver<[Car]> = self.getCars()
    
    // MARK: - Private -
    func getCars() -> Driver<[Car]> {
        return Driver.just([
                Car(id: "1", name: "BMW", price: "10000"),
                Car(id: "2", name: "Audi", price: "15000"),
                Car(id: "3", name: "Ferrari", price: "100000"),
                Car(id: "4", name: "Mersedes", price: "20000"),
                Car(id: "5", name: "Toyota", price: "8000"),
                Car(id: "6", name: "Ford", price: "6000"),
                Car(id: "7", name: "Lexus", price: "12000"),
                Car(id: "8", name: "Lada Kalina", price: "3100"),
                Car(id: "9", name: "Jeep", price: "25000"),
                Car(id: "10", name: "Tesla", price: "60000")
            ])
    }
}
