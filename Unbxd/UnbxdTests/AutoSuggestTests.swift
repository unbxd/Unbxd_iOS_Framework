//
//  AutoSuggestTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 02/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
import Unbxd

class AutoSuggestTests: XCTestCase {
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
    
    func testAutoSuggestWithKey() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shi")
        
        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithKey JSON: \(json)")
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
    
    func testAutoSuggesthWithVariant() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shir", variant: Variant(has: true, count: 2))
        
        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggesthWithVariant JSON: \(json)")
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
    
    func testAutoSuggestWithIdFilter() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shir", filter:IdFilter(field: "76678", value: "5001"))
        
        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithIdFilter JSON: \(json)")
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
    
    func testAutoSuggestWithNameFilter() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shir", filter:NameFilter(field: "vColor_uFilter", value: "Black"))
        
        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithNameFilter JSON: \(json)")
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
    
    func testAutoSuggestWithInFieldDocType() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shir", inField: DocTypeInField(resultsCount: 3))
        
        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithInFieldDocType JSON: \(json)")
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
    
    func testAutoSuggestWithPopularProductsDocType() {
        let expect = expectation(description: "AutoSuggest API Call")
        
        let query = AutoSuggestQuery(withKey: "Shir", popularProducts: DocTypePopularProducts(resultsCount: 5, fields: ["vColor_uFilter","price"]))

        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithPopularProductsDocType JSON: \(json)")
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
    
    func testAutoSuggestWithMultipleDocType() {
        let expect = expectation(description: "AutoSuggest API Call")

        let query = AutoSuggestQuery(withKey: "Shir", format: .JSON, inField: DocTypeInField(resultsCount: 4), keywordSuggestions: DocTypeKeywordSuggestions(resultsCount: 2), topQueries: DocTypeTopQueries(), promotedSuggestions: DocTypePromotedSuggestions(resultsCount: 3), popularProducts: DocTypePopularProducts(resultsCount: 5, fields: ["vColor_uFilter","price"]))

        client?.autoSuggest(query: query) { (response, httpResponse, err) in
            if let json = response {
                print("TestAutoSuggestWithMultipleDocType JSON: \(json)")
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
