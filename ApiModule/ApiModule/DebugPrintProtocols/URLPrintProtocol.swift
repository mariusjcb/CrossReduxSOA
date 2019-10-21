//
//  PrintProtocol.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire

protocol URLPrintProtocol: class {
    static func print(_ response: (HTTPURLResponse, Data))
    static func print(_ request: Alamofire.DataRequest)
    static func print(_ request: URLRequest)
    static func print(_ error: Error)
}

extension URLPrintProtocol {
    static func print(_ request: URLRequest) {
        Swift.print(
            "\n\n🌏 Requesting... [\(request.httpMethod ?? "")]",
            "\n\t|  \(request.url?.absoluteString ?? "")"
        )
        
        if let headers = request.allHTTPHeaderFields, headers.count > 0 {
            Swift.print("\n\t|  \(headers)")
        }
        
        if let stream = request.httpBodyStream,
            let data = try? Data(reading: stream) {
            let string = String(describing: String(data: data, encoding: .utf8))
            Swift.print("\n\t|  \(string))")
        }
    }
    
    static func print(_ request: DataRequest) {
        Swift.print("\n👨🏻‍💻 cURL Request:")
        debugPrint(request)
    }
    
    static func print(_ response: (HTTPURLResponse, Data)) {
        Swift.print(
            "\n\n✅ Status Code: \(response.0.statusCode)",
            "\n\t|  \(response.0.url?.absoluteString ?? "")")
        
        let headers = response.0.allHeaderFields
        if  headers.count > 0 {
            Swift.print("\n\t|  \(headers)")
        }
        
        let string = String(describing: String(data: response.1, encoding: .utf8) ?? "")
        Swift.print("\n\t|  \(string)")
    }
    
    static func print(_ error: Error) {
        Swift.print("\n\n⚠️ ERROR: \(error.localizedDescription)")
    }
}
