//
//  TodoItem.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux

public struct TodoItem: AnyReducible {
    public let id: UUID
    public let name: String
    public var isCompleted: Bool = false
    public var isDeleted: Bool = false
    
    public mutating func complete() {
        self.isCompleted = true
    }
    
    public mutating func delete() {
        self.isDeleted = true
    }
    
    public init(id: UUID, name: String, isCompleted: Bool = false, isDeleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.isDeleted = isDeleted
    }
}
