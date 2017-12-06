//
//  WeatherInfoViewModel.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherInfoViewModel: ViewModel<WeatherInfoModel> {
    
    // MARK: - Public -

    var weather: Driver<WeatherInfoRepresentation> {
        return model.weather.map { self.representation(for: $0) }
    }
    
    // MARK: - Private -
    private func representation(for weather: WeatherInfo) -> WeatherInfoRepresentation {
        let temperatureString: String
        if weather.temperature > 0 { temperatureString = "+\(weather.temperature)"}
        else { temperatureString = "\(weather.temperature)"}
        return WeatherInfoRepresentation(temperature: temperatureString,
                                         description: weather.description,
                                         city: weather.city)
    }

}
