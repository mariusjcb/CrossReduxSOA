//
//  RxAlamofire.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

public extension ObservableType where Self.Element == Alamofire.DataRequest {
    var body: Observable<String> {
        return self
            .responseData()
            .body
    }
    
    func decode<Element: Decodable>(_ type: Element.Type,
                                    with decoder: JSONDecoder) -> Observable<Element> {
        return self
            .data()
            .map {
                try decoder.decode(Element.self, from: $0)
            }
    }
    
    func validateResponse() -> Observable<(AlamofireResponse)> {
        return self.responseData().flatMap { response -> Observable<((HTTPURLResponse, Data))> in
            guard 200...300 ~= response.0.statusCode else {
                return .error(response.1.apiErrorMessage)
            }
            
            return .from(optional: response)
        }
    }
    
    func validateResponse<CustomErrorType: GenericApiError>(orPassError errorType: CustomErrorType,
                                                           using decoder: JSONDecoder)
        -> Observable<(AlamofireResponse)> {
        return self.responseData().flatMap { response -> Observable<(AlamofireResponse)> in
            guard 200...300 ~= response.0.statusCode else {
                return .error(try response.1.extractApiError(errorType, with: decoder))
            }
            
            return .from(optional: response)
        }
    }
}

private extension Data {
    var apiErrorMessage: ApiError {
        if let errorStr = String(data: self, encoding: .utf8) {
            return .custom(message: errorStr)
        } else {
            return .unknown
        }
    }
    
    func extractApiError<CustomErrorType: GenericApiError>(_ type: CustomErrorType,
                                       with decoder: JSONDecoder) throws -> CustomErrorType {
        return try decoder.decode(CustomErrorType.self, from: self)
    }
}
