//
//  TodoStoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux

class TodoStoreProvider: ReduceStoreProvider {
    typealias ReducerType = TodoReducer
    
    @available(iOS 13.0, *)
    lazy var combine: TodoCombineStore! = nil
    var rx: TodoRxStore! = nil
    
    required internal init() { }
}
