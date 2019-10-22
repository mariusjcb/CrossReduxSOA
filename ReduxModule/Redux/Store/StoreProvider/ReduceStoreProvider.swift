//
//  StoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol ReduceStoreProvider: ReduceStoreInitializable, RxReduceStoreProvider, CombineReduceStoreProvider, ReduceStoreOutputDelegate {
    func dispatch(action: ReducerType.ActionType)
    func syncStore<T: ReduceStore>(_ store: T,
                                   with currentState: T.ReducerType.StateType)
    
    init()
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
}

public extension ReduceStoreProvider {
    func syncStore<T>(_ store: T, with currentState: T.ReducerType.StateType) where T : ReduceStore {
        guard store.isWaitingForReducer else { return }
        
        store.currentState = currentState
        store.isWaitingForReducer = false
        store.outputDelegates.invoke { a in
            a.reduceStore(store, didChange: currentState)
        }
    }
    
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
        
        var outputDelegates = outputDelegates
        outputDelegates.append(self)
        
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

public extension ReduceStoreProvider {
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) {
        switch currentState {
        case let state as RxStore.ReducerType.StateType:
            syncStore(rx, with: state)
        case let state as CombineStore.ReducerType.StateType:
            syncStore(combine, with: state)
        default: break
        }
    }
    
    func reduceStore<T: ReduceStore>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) {
        switch reduceStore {
        case _ as RxStore:
            combine.isWaitingForReducer = true
        case _ as CombineStore:
            rx.isWaitingForReducer = true
        default: break
        }
    }
    
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) { }
}
