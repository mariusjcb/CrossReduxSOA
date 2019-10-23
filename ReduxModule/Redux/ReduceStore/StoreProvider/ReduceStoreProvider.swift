//
//  StoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol ReduceStoreProvider: ReduceStoreInitializable, RxReduceStoreProvider, CombineReduceStoreProvider, ReduceStoreOutputDelegate {
    func dispatch(action: ReducerType.ActionType, await: Bool)
    
    func syncStore<T: ReduceStore>(_ store: T?,
                      with currentState: T.ReducerType.StateType?,
                      error: T.ReducerType.ErrorType?)
    func syncStore<T>(_ store: T?,
                      onDispatch action: T.ReducerType.ActionType?) where T : ReduceStore
    
    init()
    
    /** Plase do not dispatch actions on Initializers or Setup methods it will desync Combine and Rx stores. */
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
}

public extension ReduceStoreProvider {
    func syncStore<T>(_ store: T?,
                      with currentState: T.ReducerType.StateType?,
                      error: T.ReducerType.ErrorType?) where T : ReduceStore {
        guard let store = store else { return }
        guard store.isWaitingForReducer else { return }
        
        store.isWaitingForReducer = false
        if let state = currentState {
            store.currentState = state
            store.outputDelegates.invoke { a in
                a.reduceStore(store, didChange: state)
            }
        } else {
            store.error = error
            store.outputDelegates.invoke { a in
                a.reduceStore(store, didFailedWith: error)
            }
        }
    }
    
    func syncStore<T>(_ store: T?,
                      onDispatch action: T.ReducerType.ActionType?) where T : ReduceStore {
        guard let store = store else { return }
        store.isWaitingForReducer = true
        store.error = nil
    }
    
    func dispatch(action: ReducerType.ActionType, await: Bool = false) {
        if let action = action as? RxStore.ReducerType.ActionType {
            rx?.dispatch(action: action, await: await)
        }
        
        if let action = action as? CombineStore.ReducerType.ActionType {
            combine?.dispatch(action: action, await: await)
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
            syncStore(rx, with: state, error: nil)
        case let state as CombineStore.ReducerType.StateType:
            syncStore(combine, with: state, error: nil)
        default: break
        }
    }
    
    func reduceStore<T: ReduceStore>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) {
        switch action {
        case let action as RxStore.ReducerType.ActionType:
            syncStore(rx, onDispatch: action)
        case let action as CombineStore.ReducerType.ActionType:
            syncStore(combine, onDispatch: action)
        default: break
        }
    }
    
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) {
        switch error {
        case let error as RxStore.ReducerType.ErrorType:
            syncStore(rx, with: nil, error: error)
        case let error as CombineStore.ReducerType.ErrorType:
            syncStore(combine, with: nil, error: error)
        default: break
        }
    }
}
