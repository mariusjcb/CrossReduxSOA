//
//  GithubReducerState.swift
//  CrossReduxSOA.Reducers
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux

public struct GithubReducerState<T: ReducibleObject>: ReducerState {
    public let items: [T]
    public let criteria: String
    public let page: Int
    
    public init(_ items: [T], criteria: String, page: Int) {
        self.items = items
        self.criteria = criteria
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case items
        case criteria
        case page
    }
}
