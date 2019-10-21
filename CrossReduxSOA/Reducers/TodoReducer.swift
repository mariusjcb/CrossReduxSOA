//
//  TodoReducer.swift
//  CrossReduxSOA
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import Foundation
import Redux

enum TodoAction {
    case addTodo(String)
    case complete(IndexSet)
    case delete(IndexSet)
    case deleteItem(TodoItem)
}

class TodoReducer: Reducer {
    typealias ActionType = TodoAction
    typealias ItemType = TodoItem
    typealias StateType = [ItemType]
    typealias ErrorType = Error
    
    func reduce(_ oldState: TodoReducer.StateType, action: TodoReducer.ActionType,
                completion: ((StateType?, ErrorType?)->())?) {
        var newState = oldState
        
        switch action {
        case .addTodo(let title):
            let item = TodoItem(id: UUID(), name: title)
            newState.append(item)
        case .complete(let offset):
            guard var item = newState.item(at: offset) else { break }
            item.complete()
            newState = newState.replacingItem(at: offset,
                                   with: item)
        case .delete(let offset):
            guard var item = newState.item(at: offset) else { break }
            
            item.delete()
            newState = newState.replacingItem(at: offset,
                                   with: item)
        case .deleteItem(let item):
            guard let offset = newState.firstIndex(where: { $0.id == item.id }) else { break }
            var item = item
            item.delete()
            newState = newState.replacingItem(at: offset,
                                   with: item)
        }
        
        completion?(newState, nil)
    }
}
