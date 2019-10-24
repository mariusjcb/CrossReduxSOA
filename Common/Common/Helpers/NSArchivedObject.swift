//
//  NSArchivedObject.swift
//  Common
//
//  Created by Marius Ilie on 24/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

private extension Encodable {
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}

public class NSArchivedObject: NSObject, NSCoding, NSSecureCoding {
    let data: Data?
    
    func valueOf<T: Codable>(_ type: T.Type) -> T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    init(value: Codable) {
        self.data = value.data
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(data, forKey: "data")
    }
    
    public required init?(coder: NSCoder) {
        self.data = coder.decodeObject(forKey: "data") as? Data
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
}
