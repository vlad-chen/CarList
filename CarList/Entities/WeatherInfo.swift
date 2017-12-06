//
//  WeatherInfo.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import Unbox

struct WeatherInfo {
    let latitude: Double
    let longitude: Double
    let condition: Condition?
    let description: String
    let icon: String
    let temperature: Double
    let city: String
    
    static var none: WeatherInfo {
        return WeatherInfo(latitude: 0,
                           longitude: 0,
                           condition: .clear,
                           description: Localizable.weatherError(),
                           icon: "11d",
                           temperature: 0,
                           city: Localizable.weatherError())
    }
    
    enum Condition: String, UnboxableEnum {
        case clear = "Clear sky";
        case few = "Few clouds";
        case scattered = "Scattered clouds";
        case broken = "Broken clouds";
        case shower = "Shower rain";
        case rain = "Rain";
        case thunderstorm = "Thunderstorm";
        case snow = "Snow";
        case mist = "Mist";
        
        var description: String {
            switch self {
            case .clear: return Localizable.weatherClearSky()
            case .few: return Localizable.weatherFewClouds()
            case .scattered: return Localizable.weatherScatteredClouds()
            case .broken: return Localizable.weatherBrokenClouds()
            case .shower: return Localizable.weatherShowerRain()
            case .rain: return Localizable.weatherRain()
            case .thunderstorm: return Localizable.weatherThunderstorm()
            case .snow: return Localizable.weatherSnow()
            case .mist: return Localizable.weatherMist()
            }
        }
    }
}

extension WeatherInfo: Unboxable {
    init(unboxer: Unboxer) throws {
        latitude = try unboxer.unbox(keyPath: "coord.lat")
        longitude = try unboxer.unbox(keyPath: "coord.lon")
        condition = unboxer.unbox(keyPath: "weather.0.main")
        description = try unboxer.unbox(keyPath: "weather.0.description")
        icon = try unboxer.unbox(keyPath: "weather.0.icon")
        temperature = try unboxer.unbox(keyPath: "main.temp")
        city = try unboxer.unbox(key: "name")
    }
}
