//
//  ReducerStoreArchiver.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Common

/** To change sync and persist functionality you can override sync() and persist() */
public protocol ReducerStoreArchiver: ReducerStoreArchiverDecisionDelegate {
    associatedtype StoreType: ReduceStore
    var statesHistory: [ReduxArchiveElement<StoreType.ReducerType.StateType>] { get set }
    
    var decisionDelegate: ReducerStoreArchiverDecisionDelegate? { get set }
    var outputDelegates: MulticastDelegate<ReducerStoreArchiverOutputDelegate> { get set }
    
    var storeLocation: String { get set }
    
    init(storeLocation: String?, outputDelegates: [ReducerStoreArchiverOutputDelegate])
}

public extension ReducerStoreArchiver where Self: ReduceStoreOutputDelegate {
    func reduceStore<T: ReduceStore>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) {
        guard reduceStore is StoreType else { return }
        guard let currentState = currentState as? StoreType.ReducerType.StateType else { return }
        guard (decisionDelegate ?? self).reducerStoreArchiver(self, shouldArchive: currentState) else { return }
        
        statesHistory.append((decisionDelegate ?? self).reducerStoreArchiver(self, archiveElementFor: currentState))
        
        guard (decisionDelegate ?? self).reducerStoreArchiver(self, shouldPersist: statesHistory) else { return }
        persist()
    }
    
    func sync() {
        do {
            let tmpStatesHistory = try DiskUtility.read([ReduxArchiveElement<StoreType.ReducerType.StateType>].self, from: storeLocation)
            let finalStatesHistory = (decisionDelegate ?? self).reducerStoreArchiver(self, syncDiskStatesHistory: tmpStatesHistory)
            
            guard (decisionDelegate ?? self).reducerStoreArchiver(self, shouldSyncStatesHistory: finalStatesHistory) else { return }
            self.statesHistory = finalStatesHistory
            outputDelegates.invoke {
                $0.reducerStoreArchiver(self, didSync: statesHistory)
            }
        } catch {
            outputDelegates.invoke {
                $0.reducerStoreArchiver(self, didReceiveError: error)
            }
        }
    }
    
    func persist() {
        saveOnDisk()
    }
    
    private func saveOnDisk() {
        do {
            try DiskUtility.write(statesHistory, in: storeLocation)
        } catch {
            outputDelegates.invoke {
                $0.reducerStoreArchiver(self, didReceiveError: error)
            }
        }
        
        outputDelegates.invoke {
            $0.reducerStoreArchiver(self, didSave: statesHistory.last!)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

public extension ReducerStoreArchiver where Self: ReducerStoreArchiverDecisionDelegate {
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       archiveElementFor state: T.StoreType.ReducerType.StateType)
        -> ReduxArchiveElement<T.StoreType.ReducerType.StateType> {
        return ReduxArchiveElement(date: Date(), state: state)
    }
    
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       shouldArchive state: T.StoreType.ReducerType.StateType) -> Bool {
        return true
    }
    
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                       shouldPersist state: [ReduxArchiveElement<T.StoreType.ReducerType.StateType>]) -> Bool {
        return true
    }
    
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                   syncDiskStatesHistory statesHistory: [ReduxArchiveElement<T.StoreType.ReducerType.StateType>])
        -> [ReduxArchiveElement<T.StoreType.ReducerType.StateType>] {
        return statesHistory
    }
    
    func reducerStoreArchiver<T: ReducerStoreArchiver>(_ archiver: T,
                                                   shouldSyncStatesHistory statesHistory: [ReduxArchiveElement<T.StoreType.ReducerType.StateType>])
        -> Bool {
        return true
    }
}

//Ignored OutputDelegate methods
public extension ReducerStoreArchiver where Self: ReduceStoreOutputDelegate {
    func reduceStore<T>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) where T : ReduceStore { }
    func reduceStore<T>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) where T : ReduceStore { }
}
