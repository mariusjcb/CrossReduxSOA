//
//  ApiModuleRepresentable.swift
//  ApiModule
//
//  Created by Marius Ilie on 25/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

public protocol ApiModuleRepresentable {
    associatedtype EndpointsType: ApiEndpoints
    
    var httpClient: Alamofire.SessionManager { get }
    var endpoints: EndpointsType { get }
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    init(requestAdapter: ApiRequestAdapter,
                httpClient: Alamofire.SessionManager?,
                endpoints: EndpointsType)
}
