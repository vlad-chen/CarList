//
//  Builder.swift
//  CarList
//
//  Created by Vlad Che on 12/3/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation

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
