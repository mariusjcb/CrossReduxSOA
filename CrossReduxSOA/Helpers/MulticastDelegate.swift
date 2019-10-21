//
//  MulticastDelegate.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 20/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation

class MulticastDelegate<T> {
    let delegates = NSHashTable<AnyObject>.weakObjects()
    
    func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func remove(_ delegate: T) {
        delegates.remove(delegate as AnyObject)
    }
    
    func invoke(_ completionHandler: (_ delegate: T) -> ()) {
        for delegate in delegates.allObjects.reversed() {
            guard let delegate = delegate as? T else { continue }
            completionHandler(delegate)
        }
    }
}
