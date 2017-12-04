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

    var representation: Driver<WeatherInfoRepresantation> {
        return model.entity.map { self.representation(for: $0) }
    }
    
    // MARK: - Private -
    func representation(for entity: WeatherInfo) -> WeatherInfoRepresantation {
        let temperatureString: String
        if entity.temperature > 0 { temperatureString = "+\(entity.temperature)"}
        else { temperatureString = "\(entity.temperature)"}
        return WeatherInfoRepresantation(temperature: temperatureString,
                                         description: entity.description,
                                         city: entity.city)
    }

}

struct WeatherInfoRepresantation {
    let temperature: String
    let description: String
    let city: String
}
