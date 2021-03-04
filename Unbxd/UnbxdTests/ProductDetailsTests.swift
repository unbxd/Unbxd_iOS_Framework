//
//  ProductDetailsTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 24/06/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
@testable import Unbxd

class ProductDetailsTests: XCTestCase {
    
    var client: Client?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        client = TestClient.shared.client
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
    
    func testSearchWithProductId() {
        let expect = expectation(description: "TestSearchWithProductId")
        
        let productId = "07800211"
        
        client?.search(productId: productId, completion: { (response, httpResponse, err) in
            print(err?.localizedDescription as Any)
            if let json = response {
                print("TestSearchWithProductId JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
            
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
}
