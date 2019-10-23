//
//  GithubCombineStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Combine
import Common
import Redux
import CrossReduxSOA_Reducers

@available(iOS 13.0, *)
public class GithubCombineStore<ReducerType: GithubReducer>: BaseGithubStore, ObservableObject {
    
    @Published public var currentState: ReducerType.StateType!
    public var state: ReducerType.StateType { return currentState }
    public var reducer: ReducerType!
    public var error: ReducerType.ErrorType? {
        didSet {
            isErrorAlertPresented = (error != nil)
        }
    }
    
    @Published public var isErrorAlertPresented: Bool = false
    @Published public var isWaitingForReducer: Bool = false
    public var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    public var actionsQueue = [ReducerType.ActionType]()
    
    //MARK: - Binding States
    
    private var cancallables = [AnyCancellable]()
    public let loadMore = PassthroughSubject<Void, Never>()
    
    @Published public var searchingCriteria: String = ""
    
    //MARK: - Methods
    
    required public init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
        setupFetchDataBinders()
    }
    
    private func setupFetchDataBinders() {
        let search = $searchingCriteria
            .throttle(for: 3, scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: { [weak self] criteria in
                self?.dispatch(action: .load(criteria: criteria))
            })
        
        let loader = loadMore
            .sink(receiveValue: { [weak self] in
                self?.dispatchLoadMore(for: self!.state)
            })
            
        cancallables.append(contentsOf: [search, loader])
    }
}
