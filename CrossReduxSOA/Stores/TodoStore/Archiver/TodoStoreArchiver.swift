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

class TodoStoreArchiver: ReducerStoreArchiver {
    typealias ReducerType = TodoReducer
    
    var statesHistory = [ReduxArchiveElement<TodoReducer>]()
    var outputDelegates = MulticastDelegate<ReducerStoreArchiverOutputDelegate>()
    
    required init(outputDelegates: [ReducerStoreArchiverOutputDelegate] = []) {
        outputDelegates.forEach {
            self.outputDelegates.add($0)
        }
    }
}
