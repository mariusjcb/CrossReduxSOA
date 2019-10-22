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
import CrossReduxSOA_Reducers
import CrossReduxSOA_Services
import CrossReduxSOA_ApiModule

public class GithubStateBuilder {
    public class func build(host: String = "https://api.github.com/")
        -> ReduxState<GithubStoreProvider<GithubReducer>> {
        let archiveListeners = [GenericReduxArchiverLogger("github_archiver")]
        var listeners: [ReduceStoreOutputDelegate] = [
            GenericReduxStoreLogger("github_logger"),
            GithubStoreArchiver(outputDelegates: archiveListeners)
        ]
        listeners.append(contentsOf: archiveListeners)
        
        let reducer = GithubReduceBuilder.build(host: host)
        return ReduxState<GithubStoreProvider<GithubReducer>>([],
                                                              reducedBy: reducer,
                                                              outputDelegates: listeners)
    }
}
