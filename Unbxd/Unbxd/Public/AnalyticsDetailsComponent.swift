//
//  AnalyticsDetailsComponent.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation


// MARK: *****AnalyticsAbstract*****

public class AnalyticsAbstract {    
    var uid: String
    var visitType: String
    var requestId: String
    var actionType = AnalyticsActionType.None
    
    init(uid:String, visitType: String, requestId: String){
        self.uid = uid
        self.visitType = visitType
        self.requestId = requestId
    }
}

class VisitorAnalytics: AnalyticsAbstract {
    override init(uid:String, visitType: String, requestId: String){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .Visitor
    }
}

public class SearchAnalytics: AnalyticsAbstract {
    var searchKey: String?
    public init(uid:String, visitType: String, requestId: String, searchKey: String){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .SearchHit
        self.searchKey = searchKey
    }
}

public class CategoryPageAnalytics: AnalyticsAbstract {
    var categoryInfo: CategoryPathAbstract?
    var pageType: PageType?
    public init(uid:String, visitType: String, requestId: String, categoryPages: CategoryPathAbstract, pageType: PageType){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .CategoryPageHit
        self.categoryInfo = categoryPages
        self.pageType = pageType
    }
}

public class ProductClickAnalytics: AnalyticsAbstract {
    var pID: String?
    var query: String?
    var page: String?
    var boxType: String?
    public init(uid:String, visitType: String, requestId: String, pID: String, query: String? = nil, pageId: String? = nil, boxType: String? = nil){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .ProductClick
        self.pID = pID
        self.query = query
        self.page = pageId
        self.boxType = boxType
    }
}

public class ProductClickAnalyticsV2: AnalyticsAbstract {
    var pID: String?
    var query: String?
    var page: String?
    var pageType: RecsV2PageType?
    var widget: Widget?
    public init(uid:String, visitType: String, requestId: String, pID: String, query: String? = nil, pageId: String? = nil, pageType: RecsV2PageType? = nil, widget: Widget? = nil){
        self.pageType = pageType
        self.widget = widget
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .ProductClick
        self.pID = pID
        self.query = query
        self.page = pageId
    }
}

public class ProductAddToCartAnalytics: AnalyticsAbstract {
    var productId: String?
    var variantId: String?
    var qty: Int?
    
    public init(uid:String, visitType: String, requestId: String, productID: String, variantId: String, quantity: Int){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .AddToCart
        self.productId = productID
        self.variantId = variantId
        self.qty = quantity
    }
}

public class ProductOrderAnalytics: AnalyticsAbstract {
    var productId: String?
    var price: Double?
    var qty: Int?
    public init(uid:String, visitType: String, requestId: String, productID: String, price: Double, quantity: Int){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .Order
        self.productId = productID
        self.price = price
        self.qty = quantity
    }
}

public class ProductDisplayPageViewAnalytics: AnalyticsAbstract {
    var skuId: String?
    public init(uid:String, visitType: String, requestId: String, skuId: String){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .ProductPageView
        self.skuId = skuId
    }
}

public class CartRemovalAnalytics: AnalyticsAbstract {
    var skuId: String?
    var variantId: String?
    var qty: Int?
    public init(uid:String, visitType: String, requestId: String, skuId: String, variantId: String, quantity: Int) {
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .CartRemoval
        self.skuId = skuId
        self.variantId = variantId
        self.qty = quantity
    }
}

public class AutoSuggestAnalytics: AnalyticsAbstract {
    var query: String?
    var docType: String?
    var intQuery: String?
    var fielName: String?
    var fieldValue: String?
    var srcField: String?
    var skuId: String?
    var unbxdPrank: Int?
    public init(uid:String, visitType: String, requestId: String, skuId: String, query: String, docType: String? = nil, internalQuery: String? = nil, fieldValue: String? = nil, fieldName: String? = nil, sourceField: String? = nil, unbxdPrank: Int? = nil) {
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .SearchHit
        self.skuId = skuId
        self.query = query
        self.docType = docType
        self.intQuery = internalQuery
        self.fieldValue = fieldValue
        self.fielName = fieldName
        self.srcField = sourceField
        self.unbxdPrank = unbxdPrank
    }
}

public class RecommendationWidgetAnalytics: AnalyticsAbstract {
    var recommendationType = RecommendationType.None
    var pids: Array<String>?
    public init(uid:String, visitType: String, requestId: String, recommendationType: RecommendationType, productIds: Array<String>) {
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .RecommendationWidgetImpression
        self.recommendationType = recommendationType
        self.pids = productIds
    }
}

public class RecommendationWidgetAnalyticsV2: AnalyticsAbstract {
    var pageType: RecsV2PageType
    var widget: Widget?
    var identifier: String?
    var pids: Array<String>?
    public init(uid:String, visitType: String, requestId: String, pageType: RecsV2PageType, widget: Widget? = nil, identifier: String? = nil, productIds: Array<String>? = nil) {
        self.pageType = pageType
        self.widget = widget
        self.identifier = identifier
        self.pids = productIds
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .RecommendationWidgetImpression
    }
}

public class SearchImpressionAnalytics: AnalyticsAbstract {
    var pids: Array<String>?
    var query: String?
    public init(uid:String, visitType: String, requestId: String, query: String, productIds: Array<String>) {
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .SearchImpression
        self.query = query
        self.pids = productIds
    }
}

public class CategoryPageImpressionAnalytics: AnalyticsAbstract {
    var pids: Array<String>?
    var categoryInfo: CategoryPathAbstract?
    var pageType: PageType?
    public init(uid:String, visitType: String, requestId: String, categoryPages: CategoryPathAbstract, pageType: PageType,  productIds: Array<String>) {
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .CategoryPageImpression
        self.categoryInfo = categoryPages
        self.pids = productIds
        self.pageType = pageType
    }
}

public class DwellTimeAnalytics: AnalyticsAbstract {
    var productId: String?
    var time: Double?
    public init(uid:String, visitType: String, requestId: String, productID: String, dwellTime: Double){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .Dwelltime
        self.productId = productID
        self.time = dwellTime
    }
}

public class FacetAnalytics: AnalyticsAbstract {
    var query: String?
    var fields : FilterAbstract?
    public init(uid:String, visitType: String, requestId: String, searchQuery: String, facetFields: FilterAbstract){
        super.init(uid: uid, visitType: visitType, requestId: requestId)
        self.actionType = .Facets
        self.query = searchQuery
        self.fields = facetFields
    }
}
