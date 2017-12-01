//
//  BaseClasses.swift
//  CarList
//
//  Created by Vlad Che on 12/1/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit

protocol Builder {
    func buildModule<P, C, M: Model<P>, VM: ViewModel<M>, V: View<VM, C>>(with view: V, provider: P, coordinator: C?)
}

extension Builder {
    func buildModule<P, C, M: Model<P>, VM: ViewModel<M>, V: View<VM, C>>(with view: V, provider: P, coordinator: C? = nil) {
        let model = M(with: provider)
        let viewModel = VM(with: model)
        view.viewModel = viewModel
        if let coordinator = coordinator { view.coordinator = coordinator }
        else if let coordinator = self as? C { view.coordinator = coordinator }
        else { fatalError("Please provide coordinator or conform protocol " +
            "\(String(describing: C.self)) by \(String(describing: self)))") }
    }
}

class Model<Provider> {
    // MARK: - Init -
    required init(with provider: Provider) {
        self.provider = provider
    }
    // MARK: - Public -
    let provider: Provider
}

class View<ViewModel, Coordinator>: UIViewController {
    // MARK: - Public -
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
    let model: Model
}
