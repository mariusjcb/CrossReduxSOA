//
//  ReducerStoreArchiverDecisionDelegate.swift
//  Redux
//
//  Created by Marius Ilie on 24/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public protocol ReducerStoreArchiverDecisionDelegate: ReduceStoreOutputDelegate {
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       shouldArchive state: T.StoreType.ReducerType.StateType) -> Bool
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       shouldPersist state: [ReduxArchiveElement<T.StoreType>]) -> Bool
}
