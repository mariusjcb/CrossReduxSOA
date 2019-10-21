//
//  GenericReduxArchiverLogger.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

public class GenericReduxArchiverLogger: ReducerStoreArchiverOutputDelegate {
    let name: String
    public init(_ name: String) {
        self.name = name
    }
    
    public func reducerStoreArchiver<T>(_ archiver: T, didSave archive: ReduxArchiveElement<T.ReducerType>) where T : ReducerStoreArchiver {
        print("🚩", name,
              "\n\t|  DATE:", archive.date,
              "\n\t|  CLASS: [\(type(of: archiver))->\(type(of: archive.target))]",
              "\n\t|  EVENT: didSave", archive.state)
    }
}
