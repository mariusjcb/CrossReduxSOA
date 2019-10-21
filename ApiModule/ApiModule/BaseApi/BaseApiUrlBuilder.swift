//
//  BaseApiUrlBuilder.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public class BaseApiUrlBuilder {
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func url(for resource: String, queryItems: [URLQueryItem] = []) -> URL {
        var urlComponents = URLComponents(string: baseUrl + resource)!
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
