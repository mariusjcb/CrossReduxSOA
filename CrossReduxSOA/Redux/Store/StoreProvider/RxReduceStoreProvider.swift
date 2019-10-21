//
//  RxStoreReactiveObject.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

protocol RxReduceStoreProvider: class {
    associatedtype RxStore: ReduceStore
    var rx: RxStore! { get set }
}
