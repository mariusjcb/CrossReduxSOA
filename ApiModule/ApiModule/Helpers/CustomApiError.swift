//
//  CustomApiError.swift
//  ApiModule
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

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
