//
//  RecommendationsQueryComponent.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

// MARK: *****RecommendationsAbstract*****

public class RecommendationQuery {    
    var region: String?
    var uid: String
    var ip: String?
    var responseFormat = ResponseFormat.JSON
    var currencyFormat: String?
    var type = RecommendationType.None
    var version: RecsVersion
    
    init(uid: String, type: RecommendationType, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        self.uid = uid
        self.type = type
        self.currencyFormat = currency
        self.region = region
        self.ip = ip
        self.responseFormat = format
        self.version = version
    }
}

public class RecommendedForYourRecomendations: RecommendationQuery {
    public init(uid: String, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .RecommendedForYou, region: region, currency: currency, format: format)
    }
}

public class RecentlyViewedRecomendations: RecommendationQuery {
    var pid: String?
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .RecentlyViewed, region: region, currency: currency, format: format)
        self.pid = productID
    }
}

public class MoreLikeThisRecomendations: RecommendationQuery {
    var pid: String?
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .MoreLikeThis, region: region, currency: currency, format: format)
        self.pid = productID
    }
}

public class ViewedAlsoViewedRecomendations: RecommendationQuery {
    var pid: String?
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .ViewerAlsoViewed, region: region, currency: currency, format: format)
        self.pid = productID
    }
}

public class BoughtAlsoBoughtRecomendations: RecommendationQuery {
    var pid: String?
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .BoughtAlsoBought, region: region, currency: currency, format: format)
        self.pid = productID
    }
}

public class CartRecomendations: RecommendationQuery {
    
    public init(uid: String, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .CartRecommendation, region: region, currency: currency, format: format)
    }
}

public class HomePageTopSellersRecomendations: RecommendationQuery {
    
    public init(uid: String, region: String? = nil, currency: String? = nil, ip: String? = nil,  format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .HomePageTopSeller, region: region, currency: currency, format: format)
    }
}

public class CategoryTopSellersRecomendations: RecommendationQuery {
    
    var category: String?
    
    var categoryLevelNames: [String]?
    
    public init(uid: String, categoryName: String? = nil, categoryLevelNames: [String]? = nil, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        super.init(uid: uid, type: .CategoryTopSeller, region: region, currency: currency, format: format)
        self.category = categoryName
        self.categoryLevelNames = categoryLevelNames
    }
}

public class PDPTopSellersRecomendations: RecommendationQuery {
    var pid: String

    public init(uid: String, productID: String, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        self.pid = productID
        super.init(uid: uid, type: .PDPPageTopSeller, region: region, currency: currency, format: format)
    }
}

public class BrandTopSellersRecomendations: RecommendationQuery {
    
    var brand: String
    
    public init(uid: String, brandName: String, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        self.brand = brandName
        super.init(uid: uid, type: .BrandTopSeller, region: region, currency: currency, format: format)
    }
}

public class CompleteTheLookRecomendations: RecommendationQuery {
    var pid: String
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        self.pid = productID
        super.init(uid: uid, type: .CompleteTheLook, region: region, currency: currency, format: format)
    }
}

public class RecommendationsV2: RecommendationQuery {
    var pageType: RecsV2PageType
    var widget: Widget
    var id: String?
    var brand: String?
    var categoryLevelNames: [String]?

    public init(pageType: RecsV2PageType, uid: String, ip: String? = nil, widget: Widget = .None, id: String? = nil, brand: String? = nil, categoryLevelNames: [String]? = nil) {
        self.pageType = pageType
        self.widget = widget
        self.id = id
        self.brand = brand
        self.categoryLevelNames = categoryLevelNames
        super.init(uid: uid, type: .None, version: .Version2)
    }
}
