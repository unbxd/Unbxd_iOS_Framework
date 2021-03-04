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
    var version = RecsVersion.Version1
    var widget = Widget.None
    
    init(uid: String, type: RecommendationType, widget: Widget = .None, region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        self.uid = uid
        self.type = type
        self.widget = widget
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
    
    public init(uid: String, region: String? = nil, currency: String? = nil, ip: String? = nil, widget: Widget = .None, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        super.init(uid: uid, type: .CartRecommendation, widget: widget, region: region, currency: currency, format: format, version: version)
    }
}

public class HomePageTopSellersRecomendations: RecommendationQuery {
    
    public init(uid: String, region: String? = nil, currency: String? = nil, ip: String? = nil, widget: Widget = .None, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        super.init(uid: uid, type: .HomePageTopSeller, widget: widget, region: region, currency: currency, format: format, version: version)
    }
}

public class CategoryTopSellersRecomendations: RecommendationQuery {
    
    var category: String?
    
    var categoryLevelNames: [String]?
    
    public init(uid: String, categoryName: String? = nil, categoryLevelNames: [String]? = nil, region: String? = nil, currency: String? = nil, ip: String? = nil, widget: Widget = .None, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        super.init(uid: uid, type: .CategoryTopSeller, widget: widget, region: region, currency: currency, format: format, version: version)
        self.category = categoryName
        self.categoryLevelNames = categoryLevelNames
    }
}

public class PDPTopSellersRecomendations: RecommendationQuery {
    var pid: String

    public init(uid: String, productID: String, region: String? = nil, currency: String? = nil, ip: String? = nil, widget: Widget = .None, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        self.pid = productID
        super.init(uid: uid, type: .PDPPageTopSeller, widget: widget, region: region, currency: currency, format: format, version: version)
    }
}

public class BrandTopSellersRecomendations: RecommendationQuery {
    
    var brand: String
    
    public init(uid: String, brandName: String, region: String? = nil, currency: String? = nil, ip: String? = nil, widget: Widget = .None, format: ResponseFormat = ResponseFormat.JSON, version: RecsVersion = .Version1) {
        self.brand = brandName
        super.init(uid: uid, type: .BrandTopSeller, widget: widget, region: region, currency: currency, format: format, version: version)
    }
}

public class CompleteTheLookRecomendations: RecommendationQuery {
    var pid: String
    
    public init(uid: String, productID: String , region: String? = nil, currency: String? = nil, ip: String? = nil, format: ResponseFormat = ResponseFormat.JSON) {
        self.pid = productID
        super.init(uid: uid, type: .CompleteTheLook, region: region, currency: currency, format: format)
    }
}
