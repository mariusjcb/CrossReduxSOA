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

public extension ApiError {
    var message: String? {
        switch self {
        case .custom(code: _, message: let message):
            return message
        case .unhandled(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown Error".localized
        }
    }
}

public extension Error {
    var message: String {
        switch self {
        case is ApiError:
            return (self as? ApiError)?.message ?? ApiError.unknown.message
        default:
            return self.localizedDescription
        }
    }
}
