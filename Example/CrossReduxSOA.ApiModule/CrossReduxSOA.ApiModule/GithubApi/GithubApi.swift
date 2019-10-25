//
//  TestApi.swift
//  CrossReduxSOA.ApiModule
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import ApiModule
import RxSwift
import Alamofire
import CrossReduxSOA_Models

public class GithubApi: ApiModule<GithubApiEndpoints> {
    public func requestRepositories(for query: String, page: Int) -> Observable<GithubItem> {
        let params = ["q": query,
                      "page": page] as [String : Any]
        
        return httpClient.rx
            .request(.get, endpoints.searchEndpoint, parameters: params)
            .decode(GithubSearchWrapper<GithubItem>.self, with: decoder)
            .map { $0.items }
            .flatMap { Observable.from($0) }
    }
}
