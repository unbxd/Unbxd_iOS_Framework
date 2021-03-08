//
//  RecsVersion2Tests.swift
//  UnbxdTests
//
//  Created by Tilak Kumar on 04/03/21.
//  Copyright © 2021 Unbxd Ltd. All rights reserved.
//

import XCTest
import Unbxd

class RecsVersion2Tests: XCTestCase {
    var client: Client?

    let kUid = "uid-1527147976993-16311"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = TestClient.shared.client
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testHomePageRecommendations() {
        let expect = expectation(description: "Home Page Recommendation API Call")
        
        let query = RecommendationsV2(pageType: .Home, uid: kUid)
        
        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("Home Page Recommendation Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testCategoryRecommendations() {
        let expect = expectation(description: "Category Page Recommendation API Call")
        
        let query = RecommendationsV2(pageType: .Category, uid: kUid, categoryLevelNames: ["men","Tops","Performance Dress Shirts","Extra Slim Shirts"])

        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("Category Page Recommendation Expecrtation failed \(err)")
            }
        }
    }
    
    func testBrandRecommendations() {
        let expect = expectation(description: "Brand Page Recommendation API Call")
        
        let query = RecommendationsV2(pageType: .Brand, uid: kUid, brand: "brand")

        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("Brand Page Recommendation Expecrtation failed \(err)")
            }
        }
    }
    
    func testPDPRecommendations() {
        let expect = expectation(description: "PDP Page Recommendation API Call")
        let kProductId = "8847330"
        
        let query = RecommendationsV2(pageType: .Pdp, uid: kUid, id: kProductId)

        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("PDP Page Recommendation Expecrtation failed \(err)")
            }
        }
    }
    
    func testCartRecommendations() {
        let expect = expectation(description: "Cart Page Recommendation API Call")

        let query = RecommendationsV2(pageType: .Cart, uid: kUid)

        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail("PDP Cart Recommendation Expecrtation failed \(err)")
            }
        }
    }
    
    func testRecommendationsWithWidget() {
        let expect = expectation(description: "Home Page Recommendation with Widget API Call")
        
        let query = RecommendationsV2(pageType: .Home, uid: kUid, ip: "12.23.122.1", widget: .Widget1)
                
        client?.recommend(recommendationQuery: query, completion: { (response, httpResponse, err) in
            guard let response = httpResponse as? HTTPURLResponse else {
                XCTFail()
                return
            }
            if (response.statusCode == 200) {
                expect.fulfill()
            }
            else {
                XCTFail()
            }
        })
        
        waitForExpectations(timeout: 10) { (error:Error?) in
            if let err = error {
                XCTFail(" Widget Home Page Recommendation Api Expecrtation failed \(err)")
            }
        }
    }
}
