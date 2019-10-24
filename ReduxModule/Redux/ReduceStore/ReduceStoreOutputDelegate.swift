//
//  ReduceStoreOutputDelegate.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol ReduceStoreOutputDelegate: class {
    func reduceStore<T: ReduceStore>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType)
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType)
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?)
}
