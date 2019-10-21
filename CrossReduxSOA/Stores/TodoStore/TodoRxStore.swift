//
//  TodoRxStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

class TodoRxStore: BaseTodoStore {
    typealias ReducerType = TodoReducer
    
    var currentState: ReducerType.StateType!
    var state: ReducerType.StateType { return currentState }
    var reducer: ReducerType!
    
    var isWaitingForReducer: Bool = false
    var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    
    required init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
    }
}
