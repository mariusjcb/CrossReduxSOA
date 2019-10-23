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
    public var storeLocation: String { return "" }
    
    public var statesHistory = [ReduxArchiveElement<StoreType>]()
    public var outputDelegates = MulticastDelegate<ReducerStoreArchiverOutputDelegate>()
    
    required public init(outputDelegates: [ReducerStoreArchiverOutputDelegate] = []) {
        outputDelegates.forEach {
            self.outputDelegates.add($0)
        }
    }
}
