//
//  StoreTests.swift
//  Redux
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
import Common
@testable import Redux

class StoreTests: XCTestCase, ReduceStoreOutputDelegate {
    
    var sut: TestStore!
    var lastAction: ReducerTestAction?
    var expectation: XCTestExpectation!
    var callOrder: Int = 0
    
    override func setUp() {
        sut = TestStore(.original, reducer: ReducerTest(), outputDelegates: [self])
    }
    
    func testStoreShouldInstantiateProperly() {
        XCTAssertEqual(sut.state.comment, "original")
        XCTAssertEqual(sut.state.items.count, 7)
        XCTAssertEqual(sut.state.items.first?.name, "1")
        XCTAssertEqual(sut.state.items.last?.name, "7")
        XCTAssertEqual(sut.isWaitingForReducer, false)
    }
    
    func testStoreShouldDispatchCorrectAction() {
        sut.dispatch(action: .remove("3", comment: "correctAction"))
    }
    
    func testStoreShouldDispatchAddAction() {
        let item = ReducerTestItem(name: "-1")
        sut.dispatch(action: .add(item, comment: "add -1"))
    }
    
    func testStoreShouldDispatchRemoveAction() {
        sut.dispatch(action: .remove("3", comment: "remove 3"))
    }
    
    func testStoreShouldDispatchRemoveActionAndReceiveError() {
        sut.dispatch(action: .remove("-1", comment: "remove_error"))
    }
    
    func testStoreShouldReduceMultipleAwaitActionsOrderedByDispatch() {
        expectation = XCTestExpectation(description: "await actionsQueue")
        print("await actionsQueue (10s)...")
        sut.dispatch(action: .remove("3", comment: "await multipleAwaitActions"))
        sut.dispatch(action: .remove("_order_1", comment: "await correct_order remove_error"))
        sut.dispatch(action: .remove("_order_2", comment: "await correct_order remove_error"))
        sut.dispatch(action: .remove("_order_3", comment: "await correct_order remove_error"))
        sut.dispatch(action: .remove("_order_4", comment: "await correct_order remove_error"))
        wait(for: [expectation], timeout: 10)
    }
    
    func reduceStore<T>(_ reduceStore: T, willDispatch action: T.ReducerType.ActionType) where T : ReduceStore {
        if let action = action as? ReducerTestAction {
            switch action {
            case .remove("3", comment: "correctAction"):
                if let last = lastAction {
                    XCTAssert(last == action)
                }
            default:
                lastAction = action
            }
        }
        
        XCTAssertEqual(sut.isWaitingForReducer, true)
    }
    
    func reduceStore<T>(_ reduceStore: T, didChange currentState: T.ReducerType.StateType) where T : ReduceStore {
        switch lastAction {
        case .add(_, comment: _):
            XCTAssertEqual(sut.state.items.count, 8)
            XCTAssertEqual(sut.state.items.last?.name, "-1")
            XCTAssertEqual(sut.state.comment, "add -1")
        case .remove("3", comment: "remove 3"):
            XCTAssertEqual(sut.state.items.count, 6)
            XCTAssertEqual(sut.state.comment, "remove 3")
        case .remove(_, comment: "await multipleAwaitActions"):
            XCTAssertEqual(sut.state.items.count, 6)
            XCTAssertEqual(sut.state.comment, "await multipleAwaitActions")
            XCTAssertEqual(sut.actionsQueue.count, 4)
        default: break
        }
        
        XCTAssertEqual(sut.isWaitingForReducer, false)
    }
    
    func reduceStore<T>(_ reduceStore: T, didFailedWith error: T.ReducerType.ErrorType?) where T : ReduceStore {
        switch lastAction {
        case .remove("-1", comment: "remove_error"):
            handleRemoveActionTest(error: error, itemsCount: 7, comment: "original")
        case .remove(_, comment: "await correct_order remove_error"):
            handleRemoveActionTest(error: error, itemsCount: 6, comment: "await multipleAwaitActions")
            handleAwaitsOrderActionsQueueTest()
        default: break
        }
        
        XCTAssertEqual(sut.isWaitingForReducer, false)
    }
    
    //MARK: - Handlers
    private func handleRemoveActionTest(error: Error?, itemsCount: Int, comment: String) {
        XCTAssertNotNil(error)
        XCTAssertNotNil(sut.error)
        XCTAssertEqual(sut.error, ReducerTestError.notFound)
        XCTAssertEqual((error as? ReducerTestError), ReducerTestError.notFound)
        XCTAssertEqual(error as? ReducerTestError, sut.error)
        
        XCTAssertEqual(sut.state.items.count, itemsCount)
        XCTAssertEqual(sut.state.comment, comment)
    }
    
    private func handleAwaitsOrderActionsQueueTest() {
        switch lastAction {
        case .remove("_order_1", comment: "await correct_order remove_error"):
            callOrder = 1
            XCTAssertEqual(sut.actionsQueue.count, 3)
        case .remove("_order_2", comment: "await correct_order remove_error"):
            callOrder = 2
            XCTAssertEqual(sut.actionsQueue.count, 2)
        case .remove("_order_3", comment: "await correct_order remove_error"):
            callOrder = 3
            XCTAssertEqual(sut.actionsQueue.count, 1)
            expectation.fulfill()
        case .remove("_order_4", comment: "await correct_order remove_error"):
            XCTAssertEqual(sut.actionsQueue.count, 0)
            expectation.fulfill()
        default: break
        }
    }
}

//MARK: - Helpers
class TestStore: ReduceStore {
    typealias ReducerType = ReducerTest
    
    var currentState: TestStore.ReducerType.StateType!
    var reducer: TestStore.ReducerType!
    var error: TestStore.ReducerType.ErrorType?
    
    var isWaitingForReducer: Bool = false
    var outputDelegates = MulticastDelegate<ReduceStoreOutputDelegate>()
    var actionsQueue: [TestStore.ReducerType.ActionType] = []
    
    required init(_ initialState: ReducerTestState, reducer: ReducerTest, outputDelegates: [ReduceStoreOutputDelegate]) {
        setup(initialState: initialState, reducer: reducer, outputDelegates: outputDelegates)
    }
}
