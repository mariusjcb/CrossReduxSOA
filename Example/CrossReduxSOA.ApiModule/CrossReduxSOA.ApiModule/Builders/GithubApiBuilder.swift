//
//  GithubApiBuilder.swift
//  CrossReduxSOA.ApiModule
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Alamofire
import Redux
import ApiModule

public class GithubApiBuilder {
    public class func build(host: String) -> GithubApi {
        let requestAdapter = ApiRequestAdapter(host: host)
        return GithubApi(requestAdapter: requestAdapter)
    }
}
