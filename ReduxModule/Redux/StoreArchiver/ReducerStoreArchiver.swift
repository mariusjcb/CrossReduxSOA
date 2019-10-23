//
//  ReducerStoreArchiver.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public struct ReduxArchiveElement<T: ReduceStore> {
    let date: Date
    let state: T.ReducerType.StateType
    let target: T
}

public protocol ReducerStoreArchiver: ReduceStoreOutputDelegate {
    associatedtype StoreType: ReduceStore
    var statesHistory: [ReduxArchiveElement<StoreType>] { get set }
    var outputDelegates: Common.MulticastDelegate<ReducerStoreArchiverOutputDelegate> { get set }
    
    var storeLocation: String { get }
    
    init(outputDelegates: [ReducerStoreArchiverOutputDelegate])
}

public extension ReducerStoreArchiver where Self: ReduceStoreOutputDelegate {
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) {
        guard let currentState = currentState as? StoreType.ReducerType.StateType else { return }
        guard let reduceStore = reduceStore as? StoreType else { return }
        
        statesHistory.append(ReduxArchiveElement(date: Date(), state: currentState, target: reduceStore))
        outputDelegates.invoke {
            $0.reducerStoreArchiver(self, didSave: statesHistory.last!)
        }
    }
}

//Ignored OutputDelegate methods
public extension ReducerStoreArchiver where Self: ReduceStoreOutputDelegate {
    func reduceStore<T>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) where T : ReduceStore { }
    func reduceStore<T>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) where T : ReduceStore { }
}
