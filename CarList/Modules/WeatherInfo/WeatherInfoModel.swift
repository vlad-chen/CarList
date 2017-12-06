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
    lazy var entity: Driver<WeatherInfo> = self.getEntity()
    
    // MARK: - Init -
    init(with weatherProvider: WeatherInfoProvider, locationProvider: LocationProvider) {
        self.weatherProvider = weatherProvider
        self.locationProvider = locationProvider
        
        observeLocationAuthorizationStatus()
    }
    
    // MARK: - Private -
    private let weatherProvider: WeatherInfoProvider
    private let locationProvider: LocationProvider
    private let disposeBag = DisposeBag()
    
    private func getEntity() -> Driver<WeatherInfo> {
        return locationProvider.location
            .distinctUntilChanged()
            .flatMapLatest({ [weak self] location in
                guard let strongSelf = self, !(location.latitude == 0 && location.longitude == 0)
                    else { return Driver<WeatherInfo>.just(WeatherInfo.none) }
                return strongSelf.weatherProvider.getWeather(for: location).retry(3).asDriver(onErrorRecover: { error in
                    AlertController.show(with: error.localizedDescription)
                    return Driver<WeatherInfo>.just(WeatherInfo.none)
                })
            })
    }
    
    private func showStatusAlert() {
        AlertController.show(with: LocationError.status.localizedDescription,
                             actions: [AlertAction.settings.default, AlertAction.cancel.default])
    }
    
    private func observeLocationAuthorizationStatus() {
        locationProvider.authorized
            .drive(onNext: {[weak self] isAuthorized in
                guard let strongSelf = self else { return }
                if !isAuthorized {
                    strongSelf.showStatusAlert()
                } else {
                    print("Location authorized")
                }
            })
            .disposed(by: disposeBag)
    }

}
