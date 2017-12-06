//
//  CarListViewController.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

class CarListViewController: View<CarListViewModel, CarListCoordinator> {
    
    // MARK: - IBOutlet -

    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - IBAction -

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        coordinator.addCar()
    }
    
    
    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        bindData()
    }
    
    // MARK: - Private -
    
    private func configureInterface() {
        coordinator.embedWeatherInfo(in: weatherView)
        tableView.register(cellType: CarListCell.self)
    }
    
    private func bindData() {
        viewModel.title.drive(self.rx.title).disposed(by: disposeBag)
        let dataSource = getDataSource()
        let sections: Driver<[Section]> = viewModel.cars.map{[Section.cars(items: $0)]}
        sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func getDataSource() -> DataSourse<Section> {
        return DataSourse<Section>(configureCell: { (_, tableView, indexPath, car) in
            let cell = tableView.dequeueReusableCell(for: indexPath) as CarListCell
            cell.nameLabel.text = car.name
            return cell
        })
    }
    
}

private enum Section {
    case cars(items: [CarRepresentation])
}

extension Section: AnimatableSectionModelType {
    
    typealias Identity = String
    var identity: String {
        switch self {
        case .cars: return "cars"
        }
    }
    
    typealias Item = CarRepresentation
    
    var items: [CarRepresentation] {
        switch self {
        case .cars(items: let items): return items.map{$0}
        }
    }
    
    init(original: Section, items: [CarRepresentation]) {
        self = .cars(items: items)
    }
}

struct CarRepresentation {
    let name: String
    let price: String
}

extension CarRepresentation: Equatable {
    static func ==(lhs: CarRepresentation, rhs: CarRepresentation) -> Bool {
        return lhs.name == rhs.name
    }
}

extension CarRepresentation: IdentifiableType {
    var identity: String { return name } 
}


