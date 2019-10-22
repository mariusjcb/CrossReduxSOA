//
//  ReducerError.swift
//  Redux
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

enum ReducerError: Error {
    case unknown
    case custom(code: Int, message: String)
}
