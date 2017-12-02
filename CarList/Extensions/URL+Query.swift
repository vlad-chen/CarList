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
        guard let pairs = self.query?.components(separatedBy: "&"), pairs.count > 0 else { return [:] }
        var results = [String: String]()
        for pair in pairs {
            let components = pair.components(separatedBy:"=")
            guard components.count > 1, let key = components.first, let value = components.last else { continue }
            results.updateValue(value, forKey: key)
        }
        return results
    }
}
