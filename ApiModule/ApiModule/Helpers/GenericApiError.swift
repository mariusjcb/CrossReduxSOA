//
//  GenericApiError.swift
//  ApiModule
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol GenericApiError: Codable, Error {
    var code: Int { get set }
    var message: String { get set }
    
    init(code: Int, message: String)
}

open class DefaultApiError: GenericApiError {
    public var code: Int
    public var message: String
    
    public required init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
