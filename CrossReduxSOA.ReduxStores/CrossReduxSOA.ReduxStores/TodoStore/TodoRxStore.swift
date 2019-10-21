//
//  TodoRxStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import Common
import CrossReduxSOA_Reducers

public class TodoRxStore: BaseTodoStore {
    public typealias ReducerType = TodoReducer
    
    public var currentState: ReducerType.StateType!
    public var state: ReducerType.StateType { return currentState }
    public var reducer: ReducerType!
    
    public var isWaitingForReducer: Bool = false
    public var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    
    required public init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
    }
}
