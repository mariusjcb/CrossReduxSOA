//
//  BaseRequestAdapter.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire

public class RequestAdapter: Alamofire.RequestAdapter {
    private let host: String
    
    public var delegate: AuthorizationAdapterDelegate?
    
    public struct HeaderKeys {
        public static var auth: String { "Authorization" }
    }
    
    public init(host: String, delegate: AuthorizationAdapterDelegate? = nil) {
        self.host = host
        self.delegate = delegate
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let url = urlRequest.url?.absoluteString ?? ""
        urlRequest.url = URL(string: "\(host.dropLast())\(url)")
        
        //Add Auth Bearer header if needed
        if let accessToken = delegate?.requestAdapter(self, authorizationTokenFor: urlRequest) {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: HeaderKeys.auth)
        }
        
        return urlRequest
    }
}

extension RequestAdapter: Alamofire.RequestRetrier {
    public func should(_ manager: Alamofire.SessionManager, retry request: Alamofire.Request, with error: Error, completion: @escaping Alamofire.RequestRetryCompletion) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(false, 0.0)
            return
        }
        
        delegate?.requestRetrier(self, didReceiveAuthorizationError: error, for: request) { success in
            completion(success, 0.0)
        }
    }
}
