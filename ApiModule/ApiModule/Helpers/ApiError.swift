//
//  ApiError.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public protocol CustomApiError: Error, Decodable, Identifiable {
    static var unknown: Self { get set }
    
    var code: Int { get set }
    var message: String { get set }
    
    init(code: Int, message: String)
}

public extension CustomApiError {
    static var unknwon: Self {
        return Self.init(code: -1, message: "Unknown Error".localized)
    }
}

public enum ApiError: Error {
    case unknown
    case custom(code: Int = -1, message: String)
}
