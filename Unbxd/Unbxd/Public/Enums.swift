//
//  Enums.swift
//  UnbxdClient
//
//  Created by tilak kumar on 17/03/18.
//  Copyright © 2018 Unbxd Limited. All rights reserved.
//

import Foundation

public enum ResponseFormat: String {
    case JSON = "json", XML = "xml"
}

public enum Facet {
    case Selected(FilterAbstract), MultiSelect, MultiLevel
}

public enum ReferenceType {
    case None, TypeId, TypeName
}

public enum FilterOperatorType {
    case None, AND, OR
}

public enum SortOrder: String {
    case None = "", ASC = "asc", DSC = "desc"
}

public enum CategoryType {
    case None, Path, Fields
}

public enum DocType: String {
    case INFIELD = "IN_FIELD", POPULARPRODUCTS = "POPULAR_PRODUCTS", TOPSEARCHQUERIES = "TOP_SEARCH_QUERIES", KEYWORDSUGGESTION = "KEYWORD_SUGGESTION", PROMOTED_SUGGESTIONS = "PROMOTED_SUGGESTIONS"
}

public enum AnalyticsActionType: String {
    case None = "", Visitor = "visitor", SearchHit = "search", CategoryPageHit = "categoryPage", ProductClick = "click", AddToCart = "cart", Order = "order", ProductPageView = "product_view", CartRemoval = "cartRemoval", RecommendationWidgetImpression = "EXPERIENCE_IMPRESSION", SearchImpression = "search_impression", CategoryPageImpression = "browse_impression", Dwelltime = "dwellTime", Facets = "facets"
    
}

public enum RecommendationType: String {
    case None = "", RecommendedForYou = "recommend", RecentlyViewed = "recently-viewed", MoreLikeThis = "more-like-these", ViewerAlsoViewed = "also-viewed", BoughtAlsoBought = "also-bought", CartRecommendation = "cart-recommend", HomePageTopSeller = "top-sellers", CategoryTopSeller = "category-top-sellers", PDPPageTopSeller = "pdp-top-sellers", BrandTopSeller = "brand-top-sellers", CompleteTheLook = "complete-the-look"
    
    public func analyticsBoxType() -> String {
        switch self {
        case .RecommendedForYou:
            return "RECOMMENDED_FOR_YOU"
        case .RecentlyViewed:
            return "RECENTLY_VIEWED"
        case .MoreLikeThis:
            return "MORE_LIKE_THESE"
        case .ViewerAlsoViewed:
            return "ALSO_VIEWED"
        case .BoughtAlsoBought:
            return "ALSO_BOUGHT"
        case .CartRecommendation:
            return "CART_RECOMMEND"
        case .HomePageTopSeller:
            return "TOP_SELLERS"
        case .CategoryTopSeller:
            return "CATEGORY_TOP_SELLERS"
        case .PDPPageTopSeller:
            return "PDP_TOP_SELLERS"
        case .BrandTopSeller:
            return "BRAND_TOP_SELLERS"
        case .CompleteTheLook:
            return "COMPLETE_THE_LOOK"
        default:
            return ""
        }
    }
}

public enum PageType: String {
    case Boolean = "BOOLEAN", CategoryPath  = "CATEGORY_PATH", TaxonomyNode = "TAXONOMY_NODE", Attribute = "ATTRIBUTE", Url = "URL"
}

public enum RecsV2PageType: String {
    case NONE = "",
         Home = "HOME",
         Category = "CATEGORY",
         Brand = "BRAND",
         Pdp = "PRODUCT",
         Cart = "CART"
}

public enum RecsVersion {
    case Version1, Version2
}

public enum Widget: String {
    case None = "", Widget1 = "WIDGET1", Widget2 = "WIDGET2", Widget3 = "WIDGET3"
}
