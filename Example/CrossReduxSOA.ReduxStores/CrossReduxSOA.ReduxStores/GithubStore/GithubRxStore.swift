//
//  GithubRxStore.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux
import Common
import CrossReduxSOA_Reducers
import RxSwift

public class GithubRxStore<ReducerType: GithubReducer>: BaseGithubStore {
    
    public var currentState: ReducerType.StateType! {
        didSet {
            stateObservable.onNext(state)
        }
    }
    
    public var state: ReducerType.StateType { return currentState }
    public var reducer: ReducerType!
    public var error: ReducerType.ErrorType?
    
    public var isWaitingForReducer: Bool = false
    public var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    public var actionsQueue = [ReducerType.ActionType]()
    
    //MARK: - Binding States
    
    private var disposeBag = DisposeBag()
    public let loadMore = PublishSubject<Void>()
    
    lazy private(set) var stateObservable = PublishSubject<ReducerType.StateType>()
    public let searchingCriteriaSubject = PublishSubject<String>()
    
    //MARK: - Methods
    
    required public init(_ initialState: ReducerType.StateType,
                  reducer: ReducerType,
                  outputDelegates: [ReduceStoreOutputDelegate] = []) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
        setupFetchDataBinders()
    }
    
    private func setupFetchDataBinders() {
        searchingCriteriaSubject
            .throttle(.seconds(3), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] criteria in
                self?.dispatch(action: .load(criteria: criteria))
            }).disposed(by: disposeBag)
        
        loadMore
            .withLatestFrom(stateObservable)
            .subscribe(onNext: { [weak self] state in
                self?.dispatchLoadMore(for: state)
            }).disposed(by: disposeBag)
    }
}
