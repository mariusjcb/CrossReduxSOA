//
//  RxAlamofireResponse.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public typealias AlamofireResponse = (HTTPURLResponse, Data)
public extension ObservableType where Self.Element == AlamofireResponse {
    var body: Observable<String> {
        return self
            .map {
                String(data: $0.1, encoding: .utf8)!
            }
    }
    
    func decode<Element: Decodable>(_ type: Element.Type,
                                    with decoder: JSONDecoder) -> Observable<Element> {
        return self
            .map {
                try decoder.decode(Element.self, from: $0.1)
            }
    }
}
