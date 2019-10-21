//
//  TodoStoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import CrossReduxSOA_Reducers

public class TodoStoreProvider<ReducerType: TodoReducer>: ReduceStoreProvider {
    @available(iOS 13.0, *)
    lazy public var combine: TodoCombineStore<ReducerType>! = nil
    public var rx: TodoRxStore<ReducerType>! = nil
    
    required public init() { }
}
