//
//  GithubCombineStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common
import Redux
import CrossReduxSOA_Reducers

@available(iOS 13.0, *)
public class GithubCombineStore<ReducerType: GithubReducer>: BaseGithubStore, ObservableObject {
    @Published public var currentState: ReducerType.StateType!
    public var state: ReducerType.StateType { return currentState }
    public var reducer: ReducerType!
    
    @Published public var isWaitingForReducer: Bool = false
    public var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    
    required public init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
    }
}
