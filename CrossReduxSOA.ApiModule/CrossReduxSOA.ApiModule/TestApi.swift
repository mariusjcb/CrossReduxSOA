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

public class TestApi: ApiModule {
    public func test() -> Observable<AlamofireResponse> {
        return httpClient.rx
            .request(.get, "/1")
    }
}
