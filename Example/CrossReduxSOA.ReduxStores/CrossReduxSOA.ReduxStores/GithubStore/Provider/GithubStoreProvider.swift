//
//  GithubStoreProvider.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import CrossReduxSOA_Reducers

open class GithubStoreProvider<ReducerType: GithubReducer>: ReduceStoreProvider {
    @available(iOS 13.0, *)
    lazy public var combine: GithubCombineStore<ReducerType>! = nil
    public var rx: GithubRxStore<ReducerType>! = nil
    
    required public init() { }
}
