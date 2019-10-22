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
    
    @Published public var isWaitingForReducer: Bool = false
    public var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    
    private var cancallables = [AnyCancellable]()
    let fetchData = PassthroughSubject<String, Never>()
    @Published public var searchingCriteria: String = "" {
        didSet {
            fetchData.send(searchingCriteria)
        }
    }
    
    required public init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
        setupFetchData()
    }
    
    private func setupFetchData() {
        let cancellable = fetchData
            .throttle(for: 3, scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: {
                self.dispatch(action: .search($0))
            })
        cancallables.append(cancellable)
    }
}
