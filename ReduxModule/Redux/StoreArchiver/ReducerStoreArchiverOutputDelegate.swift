//
//  ReducerStoreArchiverOutputDelegate.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol ReducerStoreArchiverOutputDelegate: ReduceStoreOutputDelegate {
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       didSave archive: ReduxArchiveElement<T.StoreType.ReducerType.StateType>)
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       didSync states: [ReduxArchiveElement<T.StoreType.ReducerType.StateType>])
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       didReceiveError error: Error)
}
