//
//  ReducerStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

protocol ReduceStoreInitializable {
    associatedtype ReducerType: Reducer
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
}

protocol ReduceStore: class, ReduceStoreInitializable {
    var currentState: ReducerType.StateType! { get set }
    var state: ReducerType.StateType { get }
    var reducer: ReducerType! { get set }
    
    var isWaitingForReducer: Bool { get set }
    var outputDelegates: MulticastDelegate<ReduceStoreOutputDelegate> { get set }
    
    func setup(initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
    func dispatch(action: ReducerType.ActionType)
}

extension ReduceStore {
    var state: ReducerType.StateType {
        return currentState
    }
    
    func dispatch(action: ReducerType.ActionType) {
        isWaitingForReducer = true
        
        outputDelegates.invoke {
            $0.reduceStore(self, willDispatch: action)
        }
        
        reducer
            .reduce(currentState, action: action) { newState, error in
                guard let newState = newState else {
                    self.outputDelegates.invoke {
                        $0.reduceStore(self, didFailedWith: error)
                    }
                    
                    self.isWaitingForReducer = false
                    return
                }
                
                self.currentState = newState
                self.outputDelegates.invoke {
                    $0.reduceStore(self, didChange: self.currentState)
                }

                self.isWaitingForReducer = false
        }
    }
    
    func setup(initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate]) {
        self.reducer = reducer
        self.currentState = initialState
        
        outputDelegates.forEach {
            self.outputDelegates.add($0)
        }
    }
}
