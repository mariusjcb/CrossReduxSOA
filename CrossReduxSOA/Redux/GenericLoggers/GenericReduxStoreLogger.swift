//
//  GenericStoreLogger.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

class GenericReduxStoreLogger: ReduceStoreOutputDelegate {
    let name: String
    init(_ name: String) {
        self.name = name
    }
    
    func reduceStore<T>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) where T : ReduceStore {
        print("🏁", name, "[\(type(of: reduceStore))]", ":", action)
    }
    
    func reduceStore<T>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) where T : ReduceStore {
        print("🏁", name, "[\(type(of: reduceStore))]", ":", reduceStore.currentState ?? "Nil state")
    }
    
    func reduceStore<T>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) where T : ReduceStore {
        print("🏁", name, "[\(type(of: reduceStore))]", ":", error ?? "")
    }
}
