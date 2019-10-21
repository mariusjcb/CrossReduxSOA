//
//  AlamofireRequestPrintProtocol.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

final class URLRequestPrintProtocol: URLProtocol, URLPrintProtocol {
    override public class func canInit(with request: URLRequest) -> Bool {
        #if DEBUG 
        print(request)
        #endif
        
        return false
    }
}
