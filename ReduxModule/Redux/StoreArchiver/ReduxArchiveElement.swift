//
//  ReducerStoreArchiverElement.swift
//  Redux
//
//  Created by Marius Ilie on 24/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public struct ReduxArchiveElement<T: ReducerState>: Codable {
    public let date: Date
    public let state: T
    
    public init(date: Date, state: T) {
        self.date = date
        self.state = state
    }
}
