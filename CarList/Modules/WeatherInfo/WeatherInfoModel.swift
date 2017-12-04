//
//  WeatherInfoModel.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherInfoModel {
    // MARK: - Public -
    var entity: Driver<WeatherInfo> {
        return locationProvider.location
            .distinctUntilChanged()
            .flatMapLatest({ [weak self] location in
                guard let strongSelf = self else { return Driver<WeatherInfo>.just(WeatherInfo.none) }
                return strongSelf.weatherProvider.getWeather(for: location).retry(3).asDriver(onErrorRecover: { error in
                    AlertController.show(with: error.localizedDescription)
                    return Driver<WeatherInfo>.just(WeatherInfo.none)
                })
            })
    }
    
    // MARK: - Init -
    init(with weatherProvider: WeatherInfoProvider, locationProvider: LocationProvider) {
        self.weatherProvider = weatherProvider
        self.locationProvider = locationProvider
    }
    
    // MARK: - Private -
    private let weatherProvider: WeatherInfoProvider
    private let locationProvider: LocationProvider

}

extension WeatherInfoModel: DataModel {
    func loadData() {
        
    }
}
