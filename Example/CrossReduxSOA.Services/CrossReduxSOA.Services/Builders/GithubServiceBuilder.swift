//
//  ServiceBuilder.swift
//  CrossReduxSOA.Services
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import CrossReduxSOA_ApiModule

public class GithubServiceBuilder {
    public class func build(host: String) -> GithubService {
        return GithubService(api: GithubApiBuilder.build(host: host))
    }
}
