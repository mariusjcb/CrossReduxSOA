//
//  State.swift
//  Redux
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public class ReduxState<StoreProvider: ReduceStoreProvider> {
    public let outputDelegates: [ReduceStoreOutputDelegate]
    public let store: StoreProvider
    
    public init(_ initialState: StoreProvider.ReducerType.StateType,
         reducedBy reducer: StoreProvider.ReducerType,
         outputDelegates: [ReduceStoreOutputDelegate]) {
        self.outputDelegates = outputDelegates
        self.store = StoreProvider.init(initialState,
                                        reducer: reducer,
                                        outputDelegates: outputDelegates)
    }
}
