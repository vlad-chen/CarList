//
//  WeatherTarget.swift
//  CarList
//
//  Created by Vlad Che on 12/3/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation
import Moya

struct WeatherTarget {
    let location: Location
    fileprivate let apiKey = "09d11b929c40b48115681561095b36c9"
}

extension WeatherTarget: Target {
    typealias ResultType = WeatherInfo
    
    var baseURL: URL {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5") else {
            fatalError("Can't create Base URL")
        }
        return url
    }
    
    var path: String { return "/weather" }
    var method: Moya.Method { return .get }
    var sampleData: Data { return Data() }
    var task: Moya.Task { return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString) }
    var headers: [String : String]? { return ["Content-type": "application/json"] }
    var parameters: [String : Any] { return ["lat": location.latitude, "lon": location.longitude, "APPID": apiKey, "units": "metric", "lang": R.string.localizable.weatherLang()] }
    
}
