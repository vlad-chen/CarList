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
        viewModel.representation
            .drive(Binder(self) { weakSelf, location in
                weakSelf.temperatureLabel.text = location.temperature
                weakSelf.descriptionLabel.text = location.description
                weakSelf.cityLabel.text = location.city
            })
            .disposed(by: disposeBag)
    }
    
}
