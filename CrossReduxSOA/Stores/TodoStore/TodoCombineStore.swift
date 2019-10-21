//
//  TodoCombineStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common
import Redux

@available(iOS 13.0, *)
class TodoCombineStore: BaseTodoStore, ObservableObject {
    typealias ReducerType = TodoReducer
    
    @Published var currentState: ReducerType.StateType!
    var state: ReducerType.StateType { return currentState }
    var reducer: ReducerType!
    
    @Published var isWaitingForReducer: Bool = false
    var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    
    required init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
    }
}
