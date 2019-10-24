//
//  GithubStoreArchiver.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common
import Redux
import CrossReduxSOA_Reducers

open class GithubStoreArchiver<StoreType: ReduceStore>: ReducerStoreArchiver {
    public var decisionDelegate: ReducerStoreArchiverDecisionDelegate? = nil
    
    public var statesHistory = [ReduxArchiveElement<StoreType>]()
    public var outputDelegates = MulticastDelegate<ReducerStoreArchiverOutputDelegate>()
    public var storeLocation: String
    
    required public init(storeLocation: String? = nil, outputDelegates: [ReducerStoreArchiverOutputDelegate] = []) {
        self.storeLocation = storeLocation ?? String(describing: StoreType.self)
        outputDelegates.forEach {
            self.outputDelegates.add($0)
        }
        
        self.sync()
    }
    
    public func reducerStoreArchiver<T>(_ archiver: T, shouldArchive state: T.StoreType.ReducerType.StateType) -> Bool where T : ReducerStoreArchiver {
        let state = state as? GithubReducerState<StoreType.ReducerType.ItemType>
        return state?.criteria.isEmpty == false
    }
}
