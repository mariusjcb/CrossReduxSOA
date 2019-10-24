//
//  MulticastDelegateTests.swift
//  CommonTests
//
//  Created by Marius Ilie on 22/10/2019.
//  Copyright © 2019 Marius Ilie. All rights reserved.
//

import XCTest
@testable import Common

class MulticastDelegateTests: XCTestCase {

    var sut: MulticastDelegate<TestDelegate>!
    
    override func setUp() {
        sut = MulticastDelegate<TestDelegate>()
        sut.add(TestDelegate())
        sut.add(TestDelegate())
        sut.add(TestDelegate())
        sut.add(TestDelegate())
        sut.add(TestDelegate())
    }

    func testMulticastDelegateShouldInstantiateProperly() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
    }

    func testMulticastDelegateShouldAddOneDelegate() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        let testDelegate1 = TestDelegate()
        sut.add(testDelegate1)
        XCTAssertEqual(sut.delegates.allObjects.count, 1)
        XCTAssertEqual(sut.delegates.allObjects.first as? TestDelegate, testDelegate1)
    }

    func testMulticastDelegateShouldAddMultipleDelegates() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        var delegates = [TestDelegate]()
        for i in 1...100 {
            delegates.append(TestDelegate(name: "\(i)"))
        }
        
        delegates.forEach { delegate in
            sut.add(delegate)
        }
        
        XCTAssertEqual(sut.delegates.allObjects.count, 100)
        
        for delegate in sut.delegates.allObjects {
            XCTAssertNotNil(delegate as? TestDelegate)
            XCTAssertTrue(delegates.contains(delegate as! TestDelegate))
        }
    }
    
    func testMulticastDelegateShouldAddAndRemoveOneDelegate() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        let delegate = TestDelegate()
        sut.add(delegate)
        XCTAssertEqual(sut.delegates.allObjects.count, 1)
        
        sut.remove(delegate)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
    }
    
    func testMulticastDelegateShouldNotRetainWeakDelegate() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        sut.add(TestDelegate())
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        let delegate = TestDelegate()
        sut.add(delegate)
        XCTAssertEqual(sut.delegates.allObjects.count, 1)
        sut.remove(delegate)
        
        sut.add(TestDelegate())
        sut.add(TestDelegate())
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
    }
    
    func testMulticastDelegateShouldInvokeOneDelegate() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        let delegate = TestDelegate(name: "1")
        sut.add(delegate)
        XCTAssertEqual(sut.delegates.allObjects.count, 1)
        
        sut.invoke {
            XCTAssertEqual($0.name, "1")
        }
    }
    
    func testMulticastDelegateShouldNotInvokeWeakDelegates() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        for _ in 1...100 {
            sut.add(TestDelegate(name: "1"))
        }
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        sut.invoke {
            XCTAssertNotEqual($0.name, "1")
        }
    }
    
    func testMulticastDelegateShouldAddAndRemoveMultipleDelegates() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
        
        var delegates = [TestDelegate]()
        for _ in 1...100 {
            delegates.append(TestDelegate(name: "1"))
        }
        
        delegates.forEach { delegate in
            sut.add(delegate)
        }
        
        XCTAssertEqual(sut.delegates.allObjects.count, 100)
        
        for delegate in sut.delegates.allObjects {
            XCTAssertNotNil(delegate as? TestDelegate)
            XCTAssertTrue(delegates.contains(delegate as! TestDelegate))
        }
        
        for delegate in delegates {
            sut.remove(delegate)
        }
        
        XCTAssertEqual(sut.delegates.allObjects.count, 0)
    }

    //MARK: - Helpers
    
    class TestDelegate: Equatable {
        var id = UUID()
        var name: String
        
        init(name: String = "") {
            self.name = name
        }
        
        static func == (lhs: MulticastDelegateTests.TestDelegate, rhs: MulticastDelegateTests.TestDelegate) -> Bool {
            lhs.id == rhs.id
        }
    }
}
