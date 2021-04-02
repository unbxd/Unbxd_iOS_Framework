//
//  SearchTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 01/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
@testable import Unbxd

class SearchTests: XCTestCase {
    
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
    
    func testSearchWithKey() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "trouser")
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithKey JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithAnalytics() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", analytics: true)
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithAnalytics JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithRows() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", rows: 2)
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithRows JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithStart() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", rows: 2, start: 1)
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithStart JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
   
    func testSearchWithStats() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", rows: 2, start: 1, statsField: "price", variant: Variant(has: true, count: 2))
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithStats JSON: \(json)")
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
    
    func testSearchWithFields() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", fields:["title","vPrice"])
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithFields JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithVariant() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", rows: 2, start: 1, variant: Variant(has: true, count: 2))
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithVariant JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithIdFilter() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", filter:IdFilter(field: "76678", value: "5001"))
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithIdFilter JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithNameFilter() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", filter:NameFilter(field: "vColor_uFilter", value: "Black"))
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithNameFilter JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testSearchWithMultipleNameFilter() {
        let expect = expectation(description: "Search API Call")
        
        let rangeFilter = NameFilterRange(field: "price", lower: "60.0", upper: "160.0")
        
        //let query = SearchQuery(key: "Shirt", facet: .MultiSelect, filter: rangeFilter)

        
        let nameFilter1 = NameFilter(field: "collar_uFilter", value: "Point")
        let nameFilter2 = NameFilter(field: "type_uFilter", value: "Casual Shirt")
        let multipleFilters = MultipleNameFilter(filters: [nameFilter1, nameFilter2], operatorType: .AND)

        let query = SearchQuery(key: "Shirt", facet: .MultiSelect, filter: rangeFilter, multipleFilter: multipleFilters)
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithNameFilter JSON: \(json)")
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
    
    func testSearchWithMultiLevelFacet() {
        let expect = expectation(description: "Search API Call")
        
        let query = SearchQuery(key: "Shirt", facet: .MultiLevel)
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithFacet JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testFacetWithMultiselect() {
        let expect = expectation(description: "Search API Call")

        let query = SearchQuery(key: "Oil", variant: Variant(has: true, count: 1), facet: .MultiSelect, filter: NameFilter(field: "brand_uFilter", value: "Dove"), multipleFilter: MultipleNameFilter(filters: [NameFilter(field: "brand_uFilter", value: "Dove"), NameFilterRange(field: "vendor37Availability", lower: "1", upper: "NaN")], operatorType: .AND))
        
        client?.search(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestSearchWithFacet JSON: \(json)")
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
}
