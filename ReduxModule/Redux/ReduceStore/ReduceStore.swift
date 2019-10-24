//
//  ReducerStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public protocol ReduceStoreInitializable {
    associatedtype ReducerType: Reducer
    init(_ initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
}

public protocol ReduceStore: class, ReduceStoreInitializable {
    
    var currentState: ReducerType.StateType! { get set }
    var state: ReducerType.StateType { get }
    var reducer: ReducerType! { get set }
    var error: ReducerType.ErrorType? { get set }
    
    var isWaitingForReducer: Bool { get set }
    var outputDelegates: MulticastDelegate<ReduceStoreOutputDelegate> { get set }
    var actionsQueue: [ReducerType.ActionType] { get set }
    
    /** Plase do not dispatch actions on Initializers or Setup methods */
    func setup(initialState: ReducerType.StateType, reducer: ReducerType, outputDelegates: [ReduceStoreOutputDelegate])
    
    func dispatch(action: ReducerType.ActionType, await: Bool)
}

public extension ReduceStore {
    var state: ReducerType.StateType {
        return currentState
    }
    
    func dispatch(action: ReducerType.ActionType, await: Bool = true) {
        guard !isWaitingForReducer else {
            if await {
                actionsQueue.append(action)
            }
            
            return
        }
        
        isWaitingForReducer = true
        error = nil
        
        outputDelegates.invoke {
            $0.reduceStore(self, willDispatch: action)
        }
        
        reducer
            .reduce(currentState, action: action) { newState, error in
                self.isWaitingForReducer = false
                
                if let newState = newState, error == nil {
                    self.currentState = newState
                    self.outputDelegates.invoke {
                        $0.reduceStore(self, didChange: self.currentState)
                    }
                } else {
                    self.error = error
                    self.outputDelegates.invoke {
                        $0.reduceStore(self, didFailedWith: error)
                    }
                }

                if let action = self.actionsQueue.first {
                    self.actionsQueue = Array(self.actionsQueue.dropFirst())
                    self.dispatch(action: action, await: await)
                }
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
