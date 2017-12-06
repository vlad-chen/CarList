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

    var representation: Driver<WeatherInfoRepresentation> {
        return model.entity.map { self.representation(for: $0) }
    }
    
    // MARK: - Private -
    func representation(for entity: WeatherInfo) -> WeatherInfoRepresentation {
        let temperatureString: String
        if entity.temperature > 0 { temperatureString = "+\(entity.temperature)"}
        else { temperatureString = "\(entity.temperature)"}
        return WeatherInfoRepresentation(temperature: temperatureString,
                                         description: entity.description,
                                         city: entity.city)
    }

}

struct WeatherInfoRepresentation {
    let temperature: String
    let description: String
    let city: String
}
