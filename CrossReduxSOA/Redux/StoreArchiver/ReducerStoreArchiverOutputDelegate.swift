//
//  ReducerStoreArchiverOutputDelegate.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

protocol ReducerStoreArchiverOutputDelegate: class {
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       didSave archive: ReduxArchiveElement<T.ReducerType>)
}
