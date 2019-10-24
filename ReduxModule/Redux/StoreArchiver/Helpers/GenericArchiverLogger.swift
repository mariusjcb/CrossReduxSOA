//
//  GenericReduxArchiverLogger.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

open class GenericReduxArchiverLogger: ReducerStoreArchiverOutputDelegate {
    
    let name: String
    public init(_ name: String) {
        self.name = name
    }
    
    open func reducerStoreArchiver<T>(_ archiver: T, didSave archive: ReduxArchiveElement<T.StoreType.ReducerType.StateType>) where T : ReducerStoreArchiver {
        print("🚩", name,
        "\n\t|  DATE:", archive.date,
        "\n\t|  CLASS: [\(type(of: archiver))->\(T.StoreType.self)]",
        "\n\t|  EVENT: didSave", archive.state)
    }
    
    open func reducerStoreArchiver<T>(_ archiver: T, didReceiveError error: Error) where T : ReducerStoreArchiver {
        print("⚠️", name,
              "\n\t|  ERROR:", error.localizedDescription)
    }
    
    open func reducerStoreArchiver<T>(_ archiver: T, didSync states: [ReduxArchiveElement<T.StoreType.ReducerType.StateType>]) where T : ReducerStoreArchiver {
        print("📀 SYNCED - ", name,
        "\n\t|  LAST EVENT:", states.last?.date ?? "No events")
    }
}

public extension GenericReduxArchiverLogger {
    func reduceStore<T>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) where T : ReduceStore { }
    func reduceStore<T>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) where T : ReduceStore { }
    func reduceStore<T>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) where T : ReduceStore { }
}
