//
//  CrossReduxSOA_ReduxStoresTests.swift
//  CrossReduxSOA.ReduxStoresTests
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
import Redux
import CrossReduxSOA_Reducers
@testable import CrossReduxSOA_ReduxStores

class CrossReduxSOA_ReduxStoresTests: XCTestCase {

    lazy var archiveListeners = [GenericReduxArchiverLogger("archive_logger1")]
    lazy var listeners: [ReduceStoreOutputDelegate] = [
        GenericReduxStoreLogger("logger1"),
        GenericReduxStoreLogger("logger2"),
        GenericReduxStoreLogger("logger3"),
        GenericReduxStoreLogger("logger4"),
        TodoStoreArchiver(outputDelegates: archiveListeners)
    ]
    lazy var store = TodoStoreProvider([], reducer: TodoReducer(), outputDelegates: listeners)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        store.dispatch(action: .addTodo("1"))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            store.dispatch(action: .addTodo("1"))
        }
    }

}
