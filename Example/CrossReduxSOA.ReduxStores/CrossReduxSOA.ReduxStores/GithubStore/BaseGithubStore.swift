//
//  BaseGithubRxStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import CrossReduxSOA_Reducers

public protocol BaseGithubStore: ReduceStore {
    func dispatchLoadMore(for state: ReducerType.StateType)
}

extension BaseGithubStore where ReducerType: GithubReducer {
    public func dispatchLoadMore(for state: ReducerType.StateType){
        if !state.criteria.isEmpty {
            dispatch(action: .load(criteria: state.criteria),
                     await: state.page == 0)
        } else {
            dispatch(action: .clear)
        }
    }
}
