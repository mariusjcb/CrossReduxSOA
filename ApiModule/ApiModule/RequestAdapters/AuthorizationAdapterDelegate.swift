//
//  AuthorizationAdapterDelegate.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

public protocol AuthorizationAdapterDelegate: class {
    func requestRetrier(_ requestRetrier: RequestRetrier, didReceiveAuthorizationError error: Error, for request: Alamofire.Request, retryRequest: @escaping ((Bool) -> ()))
    func requestAdapter(_ requestAdapter: RequestAdapter, authorizationTokenFor urlRequest: URLRequest) -> String?
}
