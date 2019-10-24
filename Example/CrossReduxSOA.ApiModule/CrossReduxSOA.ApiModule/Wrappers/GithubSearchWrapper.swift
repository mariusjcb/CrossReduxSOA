//
//  GithubSearchWrapper.swift
//  CrossReduxSOA.ApiModule
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import CrossReduxSOA_Models

struct GithubSearchWrapper<T: Decodable>: Decodable {
    let totalCount: Int
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
