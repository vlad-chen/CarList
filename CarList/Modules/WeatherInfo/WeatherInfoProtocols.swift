//
//  WeatherInfoProtocols.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherInfoProvider {
    func getWeather(for location: Location) -> Single<WeatherInfo>
}

protocol LocationProvider {
    var authorized: Driver<Bool> {get}
    var location: Driver<Location> {get}
}

protocol WeatherInfoCoordinator {
}
