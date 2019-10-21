//
//  Reducer.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol Reducer: class {
    associatedtype ActionType
    associatedtype ItemType: AnyReducible
    associatedtype StateType
    associatedtype ErrorType: Error
    
    func reduce(_ oldState: StateType, action: ActionType,
                completion: ((StateType?, ErrorType?)->())?)
}
