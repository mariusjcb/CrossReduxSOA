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
import CrossReduxSOA_Models
import Redux

open class GithubStoreArchiver<StoreType: ReduceStore>: ReducerStoreArchiver {
    public var decisionDelegate: ReducerStoreArchiverDecisionDelegate? = nil
    
    public var statesHistory = [ReduxArchiveElement<StoreType.ReducerType.StateType>]()
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
    
    public func reducerStoreArchiver<T>(_ archiver: T, archiveElementFor state: T.StoreType.ReducerType.StateType) -> ReduxArchiveElement<T.StoreType.ReducerType.StateType> where T : ReducerStoreArchiver {
        guard let githubState = (state as? GithubReducerState<GithubItem>), githubState.criteria.isEmpty == false else {
            return ReduxArchiveElement(date: Date(), state: state)
        }
        
        let newItems = githubState.items.map { GithubItem(id: $0.id, name: "📀 OFFLINE: \($0.name)") }
        let newState = GithubReducerState(newItems, criteria: "📀 OFFLINE: \(githubState.criteria)", page: githubState.page)
        
        if let state = newState as? T.StoreType.ReducerType.StateType {
            return .init(date: Date(), state: state)
        }
            
        return ReduxArchiveElement(date: Date(), state: state)
    }
}
