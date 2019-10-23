//
//  ServiceApi.swift
//  CrossReduxSOA.Services
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import ApiModule
import RxSwift

open class SingleApiService<T: ApiModule> {
    internal var disposeBag = DisposeBag()
    
    let api: T
    public init(api: T) {
        self.api = api
    }
}
