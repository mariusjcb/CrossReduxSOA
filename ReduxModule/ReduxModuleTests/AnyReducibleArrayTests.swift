//
//  AnyReducibleArrayTests.swift
//  Redux
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
@testable import Redux

class AnyReducibleArrayTests: XCTestCase {
    
    var array: [ReducibleObject]!
    
    override func setUp() {
        array = [ReducibleObject]()
        (0...10).forEach {
            array.append(ReducibleObject(name: "\($0)"))
        }
    }
    
    func testAnyReducibleArrayShouldGetItemByInt() {
        XCTAssertEqual(array.item(at: 3)?.name, "3")
        XCTAssertEqual(array.item(at: 0)?.name, "0")
        XCTAssertEqual(array.item(at: 10)?.name, "10")
        
        XCTAssertNotEqual(array.item(at: 11)?.name, "11")
        XCTAssertNil(array.item(at: .min))
        XCTAssertNil(array.item(at: .max))
    }
    
    func testAnyReducibleArrayShouldGetItemByIndexSet() {
        XCTAssertEqual(array.item(at: IndexSet(integer: 3))?.name, "3")
        XCTAssertEqual(array.item(at: IndexSet(integer: 0))?.name, "0")
        XCTAssertEqual(array.item(at: IndexSet(integer: 10))?.name, "10")
        
        XCTAssertNotEqual(array.item(at: IndexSet(integer: 11))?.name, "11")
        XCTAssertNil(array.item(at: IndexSet(integer: .min))?.name)
        XCTAssertNil(array.item(at: IndexSet(integer: .max))?.name)
    }
    
    func testAnyReducibleArrayShouldReplaceItemAtInt() {
        array = array.replacingItem(at: 3, with: ReducibleObject(name: "-100"))
        XCTAssertEqual(array.item(at: 3)?.name, "-100")
    }
    
    func testAnyReducibleArrayShouldReplaceItemAtIndexSet() {
        array = array.replacingItem(at: IndexSet(integer: 3), with: ReducibleObject(name: "-100"))
        XCTAssertEqual(array.item(at: IndexSet(integer: 3))?.name, "-100")
    }

    //MARK: - Helpers
    struct ReducibleObject: AnyReducible {
        let id = UUID()
        let name: String
    }
}
