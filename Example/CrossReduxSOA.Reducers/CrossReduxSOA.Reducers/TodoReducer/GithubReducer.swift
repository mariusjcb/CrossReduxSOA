//
//  GithubReducer.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import CrossReduxSOA_Models
import CrossReduxSOA_Services

public enum GithubAction {
    case load(criteria: String)
    case clear
}

open class GithubReducer: Reducer {
    public typealias ActionType = GithubAction
    public typealias ItemType = GithubItem
    public typealias StateType = GithubReducerState<ItemType>
    public typealias ErrorType = Error
    
    public let githubService: GithubService
    public init(githubService: GithubService) {
        self.githubService = githubService
    }
    
    open func reduce(_ oldState: GithubReducer.StateType, action: GithubReducer.ActionType,
                completion: ((StateType?, ErrorType?)->())?) {
        var newState = oldState
        
        switch action {
        case .load(let criteria):
            guard !criteria.isEmpty else {
                clear(completion)
                return
            }
            
            if criteria != oldState.criteria {
                newState = StateType([], criteria: criteria, page: 0)
            }
            
            githubService
                .search(for: criteria, page: oldState.page + 1, completion: { items, error in
                    var newItems = newState.items
                    
                    newItems.append(contentsOf: items ?? [])
                    let newState = StateType(newItems,
                                             criteria: criteria,
                                             page: oldState.page + 1)
                    
                    completion?(newState, error)
                })
        case .clear:
            clear(completion)
        }
    }
    
    //MARK: - Helpers
    
    open func clear(_ completion: ((StateType?, ErrorType?)->())?) {
        let newState = StateType([], criteria: "", page: 0)
        completion?(newState, nil)
    }
}
