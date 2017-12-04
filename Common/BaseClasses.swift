//
//  BaseClasses.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Model<Provider> {
    // MARK: - Init -
    required init(with provider: Provider) {
        self.provider = provider
    }
    // MARK: - Public -
    let disposeBag = DisposeBag()
    let provider: Provider
}

class View<ViewModel, Coordinator>: UIViewController {
    // MARK: - Public -
    let disposeBag = DisposeBag()
    var viewModel: ViewModel {
        set { _viewModel = newValue }
        get { return safeViewModel }
    }
    var coordinator: Coordinator {
        set { _coordinator = newValue }
        get { return safeCoordinator }
    }
    
    // MARK: - Private -
    private var _viewModel: ViewModel?
    private var _coordinator: Coordinator?
    
    private var safeViewModel: ViewModel {
        guard let viewModel = _viewModel else { fatalError("No view model for \(String(describing: self))") }
        return viewModel
    }
    
    private var safeCoordinator: Coordinator {
        guard let coordinator = _coordinator else { fatalError("No coordinator for \(String(describing: self))") }
        return coordinator
    }
}

class ViewModel<Model> {
    // MARK: - Init -
    required init(with model: Model) {
        self.model = model
    }
    // MARK: - Public -
    let disposeBag = DisposeBag()
    let model: Model
}
