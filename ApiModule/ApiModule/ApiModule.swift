//
//  ApiModule.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

open class ApiModule {
    private let requestAdapter: RequestAdapter
    public let httpClient: Alamofire.SessionManager
    
    open var encoder: JSONEncoder { return JSONEncoder() }
    open var decoder: JSONDecoder { return JSONDecoder() }
    
    public init(requestAdapter: RequestAdapter,
                httpClient: Alamofire.SessionManager? = nil) {
        self.httpClient = httpClient ?? SessionManagerBuilder.makeDefaultSession(with: requestAdapter)
        self.requestAdapter = requestAdapter
    }
    
}
