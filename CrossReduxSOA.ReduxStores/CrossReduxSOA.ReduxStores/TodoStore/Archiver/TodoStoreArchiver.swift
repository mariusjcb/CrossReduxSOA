//
//  TodoStoreArchiver.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common
import Redux
import CrossReduxSOA_Reducers

public class TodoStoreArchiver: ReducerStoreArchiver {
    public typealias ReducerType = TodoReducer
    
    public var statesHistory = [ReduxArchiveElement<TodoReducer>]()
    public var outputDelegates = MulticastDelegate<ReducerStoreArchiverOutputDelegate>()
    
    required public init(outputDelegates: [ReducerStoreArchiverOutputDelegate] = []) {
        outputDelegates.forEach {
            self.outputDelegates.add($0)
        }
    }
}
