//
//  SingleApiService.swift
//  ApiModule
//
//  Created by Marius Ilie on 25/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift

open class SingleApiService<T: ApiModuleRepresentable> {
    public let disposeBag = DisposeBag()
    public let api: T
    
    public init(api: T) {
        self.api = api
    }
}
