//
//  WeatherInfoViewController.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherInfoViewController: View<WeatherInfoViewModel, WeatherInfoCoordinator> {
    
    // MARK: - IBOutlet -
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!    
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    // MARK: - Private -
    
    private func bindData() {
        viewModel.weather
            .drive(Binder(self) { weakSelf, weather in
                weakSelf.temperatureLabel.text = weather.temperature
                weakSelf.descriptionLabel.text = weather.description
                weakSelf.cityLabel.text = weather.city
            })
            .disposed(by: disposeBag)
    }

    
}

struct WeatherInfoRepresentation {
    let temperature: String
    let description: String
    let city: String
}
