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
    case search(criteria: String, page: Int)
    case clear
}

public class GithubReducer: Reducer {
    public typealias ActionType = GithubAction
    public typealias ItemType = GithubItem
    public typealias StateType = [ItemType]
    public typealias ErrorType = Error
    
    private let githubService: GithubService
    public init(githubService: GithubService) {
        self.githubService = githubService
    }
    
    public func reduce(_ oldState: GithubReducer.StateType, action: GithubReducer.ActionType,
                completion: ((StateType?, ErrorType?)->())?) {
        var newState = oldState
        
        switch action {
        case .search(let criteria, let page):
            if page == 1 {
                newState = GithubReducer.StateType()
            }
            
            githubService
                .search(for: criteria, page: page, completion: { items, error in
                    newState.append(contentsOf: items ?? [])
                    completion?(newState, error)
                })
        case .clear:
            newState = GithubReducer.StateType()
            completion?(newState, nil)
        }
    }
}
