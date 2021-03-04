//
//  UnbxdTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 05/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
@testable import Unbxd

class UnbxdTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUserId() {
        let client = TestClient.shared.client
        UserDefaults.standard.removeObject(forKey: "kUserIdCacheKey")
        UserDefaults.standard.synchronize()
        
        let userId1 = client.userId()
        XCTAssertNotNil(userId1)
        XCTAssertNotNil(userId1.id)
        XCTAssertEqual(userId1.visitType, "first_time")
        
        let userId2 = client.userId()
        XCTAssertNotNil(userId2)
        XCTAssertNotNil(userId2.id)
        XCTAssertEqual(userId1.id, userId2.id)
        XCTAssertEqual(userId2.visitType, "repeat")
    }
}
