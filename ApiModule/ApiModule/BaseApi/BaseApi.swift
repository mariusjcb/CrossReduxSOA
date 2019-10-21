//
//  BaseApi.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public class BaseApi {
    var baseUrl: String
    
    let urlBuilder: BaseApiUrlBuilder
    var publisher: TaskPublisherDataSource
    var dateDecodingStrategy: ((CodingKey) throws -> DateFormatter?) = { _ in return DateFormatter.dateOnly }
    
    var encoder = JSONEncoder()
    var decoder = JSONDecoder() {
        didSet {
            //decoder.dateDecodingStrategy = .custom(dateDecodingStrategy)
        }
    }
    
    //MARK: - Methods
    
    init(baseUrl: String, urlBuilder: BaseApiUrlBuilder? = nil, dataTaskPublisher: TaskPublisherDataSource = SessionDataPublisher(), dateDecodingStrategy: ((CodingKey) throws -> DateFormatter?)? = nil) {
        self.baseUrl = baseUrl
        
        self.urlBuilder = urlBuilder ?? BaseApiUrlBuilder(baseUrl: baseUrl)
        self.publisher = dataTaskPublisher
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            self.dateDecodingStrategy = dateDecodingStrategy
        }
    }
    
    func url(for resource: String, queryItems: [URLQueryItem] = []) -> URL {
        return urlBuilder.url(for: resource, queryItems: queryItems)
    }
    
    func request<T: Decodable>(_ dataType: T.Type,
                               from resource: String,
                               queryItems: [URLQueryItem] = []) -> AnyPublisher<T, Error> {
        return publisher
            .dataTaskPublisher(for: url(for: resource, queryItems: queryItems))
            .filter { [weak self] _ in self != nil }
            .tryMap { [weak self] data, _ in try self!.decoder.decode(T.self, from: data) }
            .eraseToAnyPublisher()
    }
}
