//
//  SessionManagerBuilder.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

public extension Alamofire.SessionManager {
    static func makeDefaultSession(with adapter: Alamofire.RequestAdapter,
                                  cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalCacheData,
                                  protocolClasses: [AnyClass]? = [],
                                  timeout: TimeInterval = 10.0)
        -> Alamofire.SessionManager {
        let configuration = URLSessionConfiguration.default
        
        //URLProtocols
        protocolClasses?.forEach { type in
            configuration.protocolClasses?.insert(type, at: 0)
        }
        configuration.protocolClasses?.insertDebugProtocolsIfNeeded()
            
        //Configure
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        configuration.requestCachePolicy = cachePolicy
        configuration.timeoutIntervalForResource = timeout
        configuration.timeoutIntervalForRequest = timeout
            
        //Setup Session
        let httpSession = Alamofire.SessionManager(configuration: configuration)
        httpSession.adapter = adapter
        return httpSession
    }
}

private extension Array where Element == AnyClass {
    mutating func insertDebugProtocolsIfNeeded() {
        #if DEBUG
        let debugClasses = URLRequestPrintProtocol.self
        self.insert(debugClasses, at: 0)
        #endif
    }
}
