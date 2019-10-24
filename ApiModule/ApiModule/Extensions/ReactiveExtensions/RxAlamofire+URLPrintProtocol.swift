//
//  RxAlamofire+URLPrintProtocol.swift
//  ApiModule
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

public extension ObservableType where Self.Element == DataRequest {
    func callUrlDebugProtocols(_ protocols: [AnyClass]?) -> Observable<Element> {
        return self.do(onNext: { element in
            protocols?.forEach { anyClass in
                switch anyClass {
                case is URLRequestPrintProtocol.Type:
                    URLRequestPrintProtocol.print(element)
                default: break
                }
            }
        }, onError: { error in
            protocols?.forEach { anyClass in
                switch anyClass {
                case is URLRequestPrintProtocol.Type:
                    URLRequestPrintProtocol.print(error)
                default: break
                }
            }
        })
    }
}

public extension ObservableType where Self.Element == AlamofireResponse {
    func callUrlDebugProtocols(_ protocols: [AnyClass]?) -> Observable<Element> {
        return self.do(onNext: { element in
            protocols?.forEach { anyClass in
                switch anyClass {
                case is URLRequestPrintProtocol.Type:
                    URLRequestPrintProtocol.print(element)
                default: break
                }
            }
        }, onError: { error in
            protocols?.forEach { anyClass in
                switch anyClass {
                case is URLRequestPrintProtocol.Type:
                    URLRequestPrintProtocol.print(error)
                default: break
                }
            }
        })
    }
}
