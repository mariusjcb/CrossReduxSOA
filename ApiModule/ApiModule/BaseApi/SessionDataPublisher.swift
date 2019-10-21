//
//  SessionDataPublisher.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol TaskPublisherDataSource {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    func dataTaskPublisher(for request: URL) -> URLSession.DataTaskPublisher
}

@available(iOS 13.0, *)
class SessionDataPublisher: TaskPublisherDataSource {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
    
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: url)
    }
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
