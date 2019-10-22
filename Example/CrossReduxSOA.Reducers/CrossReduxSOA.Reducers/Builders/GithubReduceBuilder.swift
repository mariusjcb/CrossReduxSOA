//
//  GithubReduceBuilder.swift
//  CrossReduxSOA.Reducers
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import CrossReduxSOA_Services

public class GithubReduceBuilder {
    public class func build(host: String) -> GithubReducer {
        return GithubReducer(githubService: GithubServiceBuilder.build(host: host))
    }
}
