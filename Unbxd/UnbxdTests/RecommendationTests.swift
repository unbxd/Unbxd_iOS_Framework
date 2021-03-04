//
//  RecommendationTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 14/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
import Unbxd

class RecommendationTests: XCTestCase {
    var client: Client?

    let kUid = "uid-1527147976993-16311"
    let kRegion = "usa"
    let kCurrency = "USD"
    let kProductId = "8847330"

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
    
    func testRecommendedForYouRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let forYouQuery = RecommendedForYourRecomendations(uid: kUid, region: kRegion, currency: kCurrency, format: .JSON)
        
        client?.recommend(recommendationQuery: forYouQuery, completion: { (response, httpResponse, err) in
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
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testRecentlyViewedRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = RecentlyViewedRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testMoreLikeThisRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = MoreLikeThisRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testViewedAlsoViewedRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = ViewedAlsoViewedRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testBoughtAlsoBoughtRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = BoughtAlsoBoughtRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testCartRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = CartRecomendations(uid: kUid, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testHomePageTopSellersRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = HomePageTopSellersRecomendations(uid: kUid, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testCategoryTopSellersRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = CategoryTopSellersRecomendations(uid: kUid, categoryName: "men", region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testPDPTopSellersRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = PDPTopSellersRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testBrandTopSellersRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = BrandTopSellersRecomendations(uid: kUid, brandName: "Adidas", region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
    
    func testCompleteTheLookRecomendations() {
        let expect = expectation(description: "Recommendation API Call")
        
        let query = CompleteTheLookRecomendations(uid: kUid, productID: kProductId, region: kRegion, currency: kCurrency, format: .JSON)
        
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
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            if let err = error {
                XCTFail("Api Expecrtation failed \(err)")
            }
        }
    }
}
