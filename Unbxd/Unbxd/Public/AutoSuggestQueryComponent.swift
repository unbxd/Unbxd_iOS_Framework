//
//  AutoSuggestQueryComponent.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

public struct AutoSuggestQuery {
    var version = "V2"
    var filter: FilterAbstract?
    var variant: Variant?
    var responseFormat = ResponseFormat.JSON
    var inField: DocTypeInField?
    var keywordSuggestions: DocTypeKeywordSuggestions?
    var topQueries: DocTypeTopQueries?
    var promotedSuggestions: DocTypePromotedSuggestions?
    var popularProducts: DocTypePopularProducts?

    var key: String?
    
    public init(withKey:String, format: ResponseFormat = .JSON, inField: DocTypeInField? = nil, keywordSuggestions: DocTypeKeywordSuggestions? = nil, topQueries: DocTypeTopQueries? = nil, promotedSuggestions: DocTypePromotedSuggestions? = nil, popularProducts: DocTypePopularProducts? = nil, variant: Variant? = nil, filter: FilterAbstract? = nil) {
        self.key = withKey
        self.responseFormat = format
        self.inField = inField
        self.keywordSuggestions = keywordSuggestions
        self.topQueries = topQueries
        self.promotedSuggestions = promotedSuggestions
        self.popularProducts = popularProducts
        self.variant = variant
        self.filter = filter
    }
}

// MARK: *****DocType*****

public class DocTypeAbstract {
    var resultsCount: Int?
    var docType: DocType
    
    init(docType: DocType, resultsCount: Int?) {
        self.docType = docType
        self.resultsCount = resultsCount
    }
}

public class DocTypeInField: DocTypeAbstract {
    public init(resultsCount: Int = 2) {
        super.init(docType: .INFIELD, resultsCount: resultsCount)
    }
}

public class DocTypeKeywordSuggestions: DocTypeAbstract {
    public init(resultsCount: Int = 2) {
        super.init(docType: .KEYWORDSUGGESTION, resultsCount: resultsCount)
    }
}

public class DocTypeTopQueries: DocTypeAbstract {
    public init(resultsCount: Int = 2) {
        super.init(docType: .TOPSEARCHQUERIES, resultsCount: resultsCount)
    }
}

public class DocTypePromotedSuggestions: DocTypeAbstract {
    public init(resultsCount: Int = 2) {
        super.init(docType: .PROMOTED_SUGGESTIONS, resultsCount: resultsCount)
    }
}

public class DocTypePopularProducts: DocTypeAbstract {
    var fields: Array<String>?
    
    public init(resultsCount: Int = 2, fields: Array<String>? = nil) {
        super.init(docType: .POPULARPRODUCTS, resultsCount: resultsCount)
        self.fields = fields
    }
}
