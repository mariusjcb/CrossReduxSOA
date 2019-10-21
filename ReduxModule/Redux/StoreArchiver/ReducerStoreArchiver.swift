//
//  ReducerStoreArchiver.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

public struct ReduxArchiveElement<T: Reducer> {
    let date: Date
    let state: T.StateType
    let target: AnyObject
}

public protocol ReducerStoreArchiver: ReduceStoreOutputDelegate {
    associatedtype ReducerType: Reducer
    var statesHistory: [ReduxArchiveElement<ReducerType>] { get set }
    var outputDelegates: Common.MulticastDelegate<ReducerStoreArchiverOutputDelegate> { get set }
    
    init(outputDelegates: [ReducerStoreArchiverOutputDelegate])
}

public extension ReducerStoreArchiver where Self: ReduceStoreOutputDelegate {
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) {
        guard let currentState = currentState as? ReducerType.StateType else { return }
        
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
