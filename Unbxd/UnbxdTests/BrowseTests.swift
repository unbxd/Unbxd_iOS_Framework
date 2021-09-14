//
//  BrowseTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 21/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
import Unbxd

class BrowseTests: XCTestCase {
    
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
    
    func testBrowseWithCategoryNames() {
        let expect = expectation(description: "TestBrowseWithCategoryNames")
        
        //let categoryQuery = CategoryNamePath(path: "cat120009")
        let categoryQuery = CategoryNamePath(path: "categoryPath:Fashion>Shoes")

        let browseQuery = BrowseQuery(categoryQuery: categoryQuery, pageType: PageType.Boolean)

        client?.browse(query: browseQuery) { (response, httpResponse, err) in
            if let json = response {
                print("TestBrowseWithCategoryNames JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testBrowseWithCategoryFieldName() {
        let expect = expectation(description: "TtestBrowseWithCategoryFieldName")

        let categoryQuery = CategoryNameField(field: "size", value: "Large")
        
        let browseQuery = BrowseQuery(categoryQuery: categoryQuery)
        
        client?.browse(query: browseQuery) { (response, httpResponse, err) in
            if let json = response {
                print("TestBrowseWithCategoryNames JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
}
