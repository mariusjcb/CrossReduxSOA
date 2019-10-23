//
//  GithubItem.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux

open class GithubItem: Decodable, AnyReducible {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String, isCompleted: Bool = false, isDeleted: Bool = false) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
    }
}
