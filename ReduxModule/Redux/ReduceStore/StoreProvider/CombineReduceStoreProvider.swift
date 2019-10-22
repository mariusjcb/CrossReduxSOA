//
//  CombineReactiveObject.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol CombineReduceStoreProvider: class {
    associatedtype CombineStore: ReduceStore & ObservableObject
    var combine: CombineStore! { get set }
}
