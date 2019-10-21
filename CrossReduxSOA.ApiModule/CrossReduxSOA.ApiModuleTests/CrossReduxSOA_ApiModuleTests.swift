//
//  CrossReduxSOA_ApiModuleTests.swift
//  CrossReduxSOA.ApiModuleTests
//
//  Created by Marius Ilie on 21/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
import ApiModule
import RxBlocking
@testable import CrossReduxSOA_ApiModule

class CrossReduxSOA_ApiModuleTests: XCTestCase {

    lazy var api = TestApi(requestAdapter: RequestAdapter(host: "https://jsonplaceholder.typicode.com/todos/"))
    lazy var test = try api.test()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        do {
            let response = try test.toBlocking().last()
            print(response)
            XCTAssertNotNil(response)
        } catch {
            XCTAssertThrowsError(error)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
