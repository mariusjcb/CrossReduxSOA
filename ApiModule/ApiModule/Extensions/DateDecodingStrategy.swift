//
//  DateDecodingStrategy.swift
//  ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    static func custom(_ formatterForKey: @escaping (CodingKey) throws -> DateFormatter?) -> JSONDecoder.DateDecodingStrategy {
        return .custom({ (decoder) -> Date in
            guard let codingKey = decoder.codingPath.last else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "No Coding Path Found"))
            }

            guard let container = try? decoder.singleValueContainer(),
                let text = try? container.decode(String.self) else {
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not decode date text"))
            }

            guard let dateFormatter = try formatterForKey(codingKey) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "No date formatter for date text")
            }

            if let date = dateFormatter.date(from: text) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(text)")
            }
        })
    }
}
