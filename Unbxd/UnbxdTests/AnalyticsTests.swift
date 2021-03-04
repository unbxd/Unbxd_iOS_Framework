//
//  AnalyticsTests.swift
//  UnbxdTests
//
//  Created by tilak kumar on 07/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import XCTest
@testable import Unbxd


class AnalyticsTests: XCTestCase {
    var client: Client?
    let userId = TestClient.shared.client.userId()
    let requestId = "3d3d5ab5-33e6-4706-b86a-dcd233889d0d-demo-unbxd700181503576558"

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
    
    func testVisitorAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let visitorAnalytics = VisitorAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId)

        client?.track(analyticsDetails: visitorAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testSearchAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let searchAnalytics = SearchAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, searchKey: "Shirt")

        client?.track(analyticsDetails: searchAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testCategoryPageAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let categoryQuery = CategoryNamePath(path: "category:Fashion>Socks")
        let categoryPageAnalytics = CategoryPageAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, categoryPages: categoryQuery, pageType: PageType.CategoryPath)
        
        client?.track(analyticsDetails: categoryPageAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testProductClickAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let productClickAnalytics = ProductClickAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, pID: "2301609", query: "Socks", pageId: "Order", boxType: "RECOMMENDED_FOR_YOU")
        
        client?.track(analyticsDetails: productClickAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testAddToCartAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let addToCartAnalytics = ProductAddToCartAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, productID: "2301609", variantId: "231221", quantity: 2)

        client?.track(analyticsDetails: addToCartAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testProductOrderAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let orderAnalytics = ProductOrderAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, productID: "2301609", price: 20.5, quantity: 3)

        client?.track(analyticsDetails: orderAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testProductDisplayPageAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let productDisplayPageAnalytics = ProductDisplayPageViewAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, skuId: "2034")

        client?.track(analyticsDetails: productDisplayPageAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testCartRemovalAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let cartRemovalAnalytics = CartRemovalAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, skuId: "2034", variantId: "231221", quantity: 2)

        client?.track(analyticsDetails: cartRemovalAnalytics, completion: { (response, httpResponse, err) in
            if response != nil {
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
    
    func testAutoSuggestAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let autoSuggestAnalytics = AutoSuggestAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, skuId: "2034", query: "Red Socks", docType: "IN_FIELD", internalQuery: "red", fieldValue: "Red socks", fieldName: "infield1", sourceField: "color type", unbxdPrank: 6)

        client?.track(analyticsDetails: autoSuggestAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testRecommendationAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let recommendationImpressionAnalytics = RecommendationWidgetAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, recommendationType: RecommendationType.ViewerAlsoViewed, productIds: ["1692741-1758","01692015-285","1692908-480"])

        client?.track(analyticsDetails: recommendationImpressionAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testSearchImpressionAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let searchImpressionAnalytics = SearchImpressionAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, query: "Shoes", productIds: ["1692741-1758","01692015-285","1692908-480"])

        client?.track(analyticsDetails: searchImpressionAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testCategoryPageImpressionAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let categoryPathQuery = CategoryNamePath.init(path: "men>shirt")
        let categoryPageImpression = CategoryPageImpressionAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, categoryPages: categoryPathQuery, pageType: PageType.Url, productIds: ["1692741-1758","01692015-285","1692908-480"])
        
        client?.track(analyticsDetails: categoryPageImpression, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testDwellTimeAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let dwellTimeAnalytics = DwellTimeAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, productID: "2301609", dwellTime: 60)
        
        client?.track(analyticsDetails: dwellTimeAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
    
    func testFacetAnalytics() {
        let expect = expectation(description: "Analytics API Call")
        
        let facetAnalytics = FacetAnalytics(uid: userId.id, visitType: userId.visitType, requestId: requestId, searchQuery: "Shirts", facetFields: NameFilter(field: "fit_fq", value: "Fitted"))

        client?.track(analyticsDetails: facetAnalytics, completion: { (response, httpResponse, err) in
            if (err == nil) {
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
