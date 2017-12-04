//
//  CarDetails.swift
//  CarList
//
//  Created by Vlad Che on 12/3/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation

struct CarDetails {
    let id: String
    let name: String
    let price: String
    let engine: String
    let transmission: Transmission
    let condition: Condition
    
    enum Transmission {
        case manual, automate
    }
    
    enum Condition {
        case poor, fair, good, excellent
//        var description: String {
//            switch self {
//            case .poor: return "
//            }
//        }
    }
}


