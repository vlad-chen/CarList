//
//  WeatherService.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension WeatherService: WeatherInfoProvider {
    func getWeather(for location: Location) -> Single<WeatherInfo> {
        return provider.rx.request(WeatherTarget(location: location))
    }
}

class WeatherService {
    // MARK: - Private -
    fileprivate let provider = MoyaProvider<WeatherTarget>.default
}
