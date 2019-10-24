//
//  SearchService.swift
//  CrossReduxSOA.Services
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import CrossReduxSOA_Models
import CrossReduxSOA_ApiModule
import ApiModule
import RxSwift

open class GithubService: SingleApiService<GithubApi> {
    open func search(for criteria: String, page: Int, completion: (([GithubItem]?, ApiError?)->())? = nil) {
        api.requestRepositories(for: criteria, page: page)
            .toArray()
            .subscribe(onSuccess: {
                completion?($0, nil)
            }, onError: {
                completion?(nil, ApiError.from($0))
            }).disposed(by: disposeBag)
    }
}
