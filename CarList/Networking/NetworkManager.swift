//
//  NetworkManager.swift
//  CarList
//
//  Created by Vlad Che on 11/30/17.
//  Copyright © 2017 Vlad Che. All rights reserved.
//

import Foundation

// MARK: - Protocols -

protocol NetworkManaging {
    
}

// MARK: - Enums -

enum Encoding {
    case url, json
}

enum HTTPMetod {
    case get, post, update, delete
}

// MARK: - Typealiases -

typealias Response = HTTPURLResponse
typealias Success = (Response, Data) -> Void
typealias Failure = (Response, Error) -> Void

protocol Endpoint {
    var path: String {get set}
    var params: [String: String] {get set}
    var encoding: Encoding {get set}
    var data: Data {get set}
    var method: HTTPMetod {get set}
}

// MARK: - NetworkManager -

class NetworkManager {
    
}

extension NetworkManager: NetworkManaging { /* MARK: NetworkManaging \*/
    
}
