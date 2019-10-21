//
//  RxAlamofireSessionManager.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

public extension Reactive where Base == Alamofire.SessionManager {
    /** Request with validation response. To implement CustomError type instead of using standard ApiError enum please use requestWithoutValidation method. */
    func request(_ method: Alamofire.HTTPMethod,
                        _ url: URLConvertible,
                        parameters: [String: Any]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil) -> Observable<AlamofireResponse> {
        return self
            .requestWithoutValidation(method, url, parameters: parameters, encoding: encoding, headers: headers)
            .do(onNext: URLRequestPrintProtocol.print)
            .validateResponse()
    }
    
    /** Request without validation response. It allows you to implement CustomError type instead of using standard ApiError enum. */
    func requestWithoutValidation(_ method: Alamofire.HTTPMethod,
                        _ url: URLConvertible,
                        parameters: [String: Any]? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil) -> Observable<DataRequest> {
        return self.request(method, url, parameters: parameters, encoding: encoding, headers: headers)
                    .do(onNext: URLRequestPrintProtocol.print)
    }
}
