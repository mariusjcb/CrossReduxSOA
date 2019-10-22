//
//  ApiError.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public enum ApiError: Error {
    case unknown
    case custom(code: Int = -1, message: String)
    case unhandled(Error)
    
    public static func from(_ error: Error) -> ApiError {
        if let error = error as? ApiError {
            return error
        } else {
            return ApiError.unhandled(error)
        }
    }
}
