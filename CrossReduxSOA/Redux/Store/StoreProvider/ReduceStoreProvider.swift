//
//  StoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

protocol ReduceStoreProvider: ReduceStoreInitializable, RxReduceStoreProvider, CombineReduceStoreProvider {
    func dispatch(action: ReducerType.ActionType)
    init()
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
}

extension ReduceStoreProvider {
    func dispatch(action: ReducerType.ActionType) {
        if let action = action as? RxStore.ReducerType.ActionType {
            rx?.dispatch(action: action)
        }
        
        if let action = action as? CombineStore.ReducerType.ActionType {
            combine?.dispatch(action: action)
        }
    }
    
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate]) {
        self.init()
        
        if let initialState = initialState as? RxStore.ReducerType.StateType,
            let reducer = reducer as? RxStore.ReducerType {
            rx = RxStore(initialState, reducer: reducer, outputDelegates: outputDelegates)
        }
        
        if #available(iOS 13.0, *) {
            if let initialState = initialState as? CombineStore.ReducerType.StateType,
                let reducer = reducer as? CombineStore.ReducerType {
                combine = CombineStore(initialState, reducer: reducer, outputDelegates: outputDelegates)
            }
        }
    }
}


