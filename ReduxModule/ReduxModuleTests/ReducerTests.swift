//
//  ReducerTests.swift
//  Redux
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
@testable import Redux

class ReducerTests: XCTestCase {

    var state: ReducerTestState!
    
    override func setUp() {
        state = .original
    }

    func testReducerShouldApplyAddAction() {
        let sut = ReducerTest()
        let item = ReducerTestItem(name: "-1")
        sut.reduce(state, action: .add(item, comment: "add -1")) { newState, _ in
            XCTAssertNotNil(newState)
            
            self.state = newState!
            XCTAssertEqual(self.state.items.count, 8)
            XCTAssertEqual(self.state.items.last?.id, item.id)
            XCTAssertEqual(self.state.comment, "add -1")
        }
    }

    func testReducerShouldApplyRemoveAction() {
        let sut = ReducerTest()
        sut.reduce(state, action: .remove("3", comment: "remove 3")) { newState, error in
            XCTAssertNotNil(newState)
            
            self.state = newState!
            XCTAssertEqual(self.state.items.count, 6)
            XCTAssertEqual(self.state.comment, "remove 3")
        }
    }

    func testReducerShouldApplyRemoveActionAndReturnError() {
        let sut = ReducerTest()
        sut.reduce(state, action: .remove("-1", comment: "remove_error")) { newState, error in
            XCTAssertNotNil(newState)
            XCTAssertNotNil(error)
            
            self.state = newState!
            XCTAssertEqual(self.state.items.count, 7)
            XCTAssertEqual(error, ReducerTestError.notFound)
            XCTAssertEqual(self.state.comment, "original")
        }
    }
}

//MARK: - Helpers
enum ReducerTestAction: Equatable {
    static func == (lhs: ReducerTestAction, rhs: ReducerTestAction) -> Bool {
        switch lhs {
        case .add(let lhsitem, comment: let lhscomment):
            switch rhs {
            case .add(let rhsitem, comment: let rhscomment):
                return lhsitem == rhsitem && lhscomment == rhscomment
            case .remove(_, comment: _):
                return false
            }
        case .remove(let lhsrmv, comment: let lhscomment):
            switch rhs {
            case .add(_, comment: _):
                return false
            case .remove(let rhsrmv, comment: let rhscomment):
                return lhsrmv == rhsrmv && lhscomment == rhscomment
            }
        }
    }
    
    case add(ReducerTestItem, comment: String)
    case remove(String, comment: String)
}

struct ReducerTestItem: ReducibleObject, Equatable {
    let id = UUID()
    let name: String
}

struct ReducerTestState: ReducerState {
    let items: [ReducerTestItem]
    let comment: String
    
    static var original: ReducerTestState {
        ReducerTestState(items: [ReducerTestItem(name: "1"),
                                 ReducerTestItem(name: "2"),
                                 ReducerTestItem(name: "3"),
                                 ReducerTestItem(name: "4"),
                                 ReducerTestItem(name: "5"),
                                 ReducerTestItem(name: "6"),
                                 ReducerTestItem(name: "7")], comment: "original")
    }
}

enum ReducerTestError: Error {
    case notFound
}

class ReducerTest: Reducer {
    typealias StateType = ReducerTestState
    
    typealias ActionType = ReducerTestAction
    typealias ItemType = ReducerTestItem
    typealias ErrorType = ReducerTestError
    
    func reduce(_ oldState: ReducerTestState, action: ReducerTestAction, completion: ((ReducerTestState?, ReducerTestError?) -> ())?) {
        switch action {
        case .add(let item, comment: let comment):
            var items = oldState.items
            items.append(item)
            
            let newState = ReducerTestState(items: items, comment: comment)
            completion?(newState, nil)
        case .remove(let name, comment: let comment):
            if comment.contains("await") {
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0, execute: {
                    self.handleRemove(name: name, comment: comment, oldState: oldState, action: action, completion: completion)
                })
            } else {
                handleRemove(name: name, comment: comment, oldState: oldState, action: action, completion: completion)
            }
        }
    }
    
    private func handleRemove(name: String, comment: String, oldState: ReducerTestState, action: ReducerTestAction, completion: ((ReducerTestState?, ReducerTestError?) -> ())?) {
        let items = oldState.items.filter({ $0.name != name })
        
        if items.count == oldState.items.count {
            completion?(oldState, .notFound)
        } else {
            let newState = ReducerTestState(items: items, comment: comment)
            completion?(newState, nil)
        }
    }
}
