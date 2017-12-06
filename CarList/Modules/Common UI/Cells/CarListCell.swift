//
//  CarListCell.swift
//  CarList
//
//  Created by Vlad Che on 12/2/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import UIKit
import Reusable

class CarListCell: UITableViewCell, NibReusable {
    // MARK: - IBOutlet -
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
}
