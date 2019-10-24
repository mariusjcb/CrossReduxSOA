//
//  StateBuilder.swift
//  CrossReduxSOA.ReduxStores
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire
import Redux
import ApiModule
import CrossReduxSOA_Models
import CrossReduxSOA_Reducers
import CrossReduxSOA_Services
import CrossReduxSOA_ApiModule

public class GithubStateBuilder {
    public class func build(host: String = "https://api.github.com/")
        -> ReduxState<GithubStoreProvider<GithubReducer>> {
        let archiveListeners = [GenericReduxArchiverLogger("github_archiver")]
        var listeners: [ReduceStoreOutputDelegate] = [GenericReduxStoreLogger("github_logger")]
        let defaultStoreArchiver = GithubStoreArchiver<GithubRxStore>(outputDelegates: archiveListeners)
            
        listeners.append(defaultStoreArchiver)
        listeners.append(contentsOf: archiveListeners)
        if #available(iOS 13.0, *) {
            listeners.append(GithubStoreArchiver<GithubCombineStore>(outputDelegates: archiveListeners))
        }
        
        let reducer = GithubReduceBuilder.build(host: host)
        let initialState = defaultStoreArchiver.statesHistory.last?.state ?? .init([], criteria: "", page: 0)
        return ReduxState<GithubStoreProvider<GithubReducer>>(initialState,
                                                              reducedBy: reducer,
                                                              outputDelegates: listeners)
    }
}
