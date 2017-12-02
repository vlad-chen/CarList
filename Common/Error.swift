//
//  Error.swift
//  CarList
//
//  Created by Vlad Che on 12/2/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case with(message: String)
    case idc
    var localizedDescription: String {
        switch self {
        case .with(let message): return message
        case .idc: return "Something wrong happened"
        }
    }
}
