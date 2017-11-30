//
//  URL+Query.swift
//  GithubSearch
//
//  Created by Test on 09.11.17.
//  Copyright © 2017 Test. All rights reserved.
//

import Foundation

extension URL {
    var queryParams: [String: String] {
        var results = [String: String]()
        if let pairs = self.query?.components(separatedBy: "&"), pairs.count > 0 {
            for pair: String in pairs {
                if let keyValue = pair.components(separatedBy:"=") as [String]? {
                    results.updateValue(keyValue[1], forKey: keyValue[0])
                }
            }
        }
        return results
    }
}
