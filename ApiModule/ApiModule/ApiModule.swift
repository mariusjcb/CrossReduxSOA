//
//  ApiModule.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

open class ApiModule<EndpointsType: ApiEndpoints>: ApiModuleRepresentable {
    private let requestAdapter: ApiRequestAdapter
    public let httpClient: Alamofire.SessionManager
    public let endpoints: EndpointsType
    
    public var encoder: JSONEncoder { return JSONEncoder() }
    public var decoder: JSONDecoder { return JSONDecoder() }
    
    required public init(requestAdapter: ApiRequestAdapter,
                httpClient: Alamofire.SessionManager? = nil,
                endpoints: EndpointsType = EndpointsType()) {
        self.endpoints = endpoints
        self.httpClient = httpClient ?? .makeDefaultSession(with: requestAdapter)
        self.requestAdapter = requestAdapter
    }
}
