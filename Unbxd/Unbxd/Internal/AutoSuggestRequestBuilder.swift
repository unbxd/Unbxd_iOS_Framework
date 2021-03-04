//
//  AutoSuggestRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 02/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class AutoSuggestRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    let kDocTypeInFieldLabel = "&inFields.count="
    let kDocTypePopularProductsLabel = "&popularProducts.count="
    let kDocTypePopularProductsFieldsLabel = "&popularProducts.fields="
    let kDocTypeKeywordSuggestionsLabel = "&keywordSuggestions.count="
    let kDocTypeTopQueriesLabel = "&topQueries.count="
    let kDocTypePromotedSuggestionsLabel = "&promotedSuggestion.count="
    
    func parse(query: Any) -> String? {
        guard let suggestQuery = query as? AutoSuggestQuery else {
            return nil
        }
        var urlStr = ClientRequestType.AutoSuggest.baseUrl()
        
        if urlStr != nil {
            urlStr = urlStr! + "q=\(suggestQuery.key!)\(kVersionLabel)\(suggestQuery.version)\(kResponseFormatLabel)\(suggestQuery.responseFormat.rawValue)"
            
            // MARK: Adding Variants
            if let variant = suggestQuery.variant {
                urlStr = urlStr! + "\(kVariantEnabledLabel)\(String(variant.enabled))"
                
                if let count = variant.count {
                    urlStr = urlStr! + "\(kVariantCountLabel)\(count)"
                }
            }
            
            // MARK: Adding Filters
            if let filter = suggestQuery.filter {
                if let textFilter = filter as? TextFilter {
                    if textFilter is IdFilter {
                        urlStr = urlStr! + "\(kIdFilterLabel)\(textFilter.field!):\(textFilter.value!)"
                    }
                    else if textFilter is NameFilter {
                        urlStr = urlStr! + "\(kNameFilterLabel)\(textFilter.field!):\(textFilter.value!)"
                    }
                }
                else if let rangeFilter = filter as? FilterRangeAbstract {
                    if rangeFilter is NameFilterRange {
                        urlStr = urlStr! + "\(kNameFilterLabel)\(rangeFilter.field!):[\(rangeFilter.lowerRange!) TO \(rangeFilter.upperRange!)]"
                    }
                    else if rangeFilter is IdFilterRange {
                        urlStr = urlStr! + "\(kIdFilterLabel)\(rangeFilter.field!):[\(rangeFilter.lowerRange!) TO \(rangeFilter.upperRange!)]"
                    }
                }
            }
            
            // MARK: Adding DocType
            
            if let docType = suggestQuery.inField {
                urlStr = urlStr! + "\(kDocTypeInFieldLabel)\(docType.resultsCount!)"
            }
            
            if let docType = suggestQuery.topQueries {
                urlStr = urlStr! + "\(kDocTypeTopQueriesLabel)\(docType.resultsCount!)"
            }
            
            if let docType = suggestQuery.promotedSuggestions {
                urlStr = urlStr! + "\(kDocTypePromotedSuggestionsLabel)\(docType.resultsCount!)"
            }
            
            if let docType = suggestQuery.keywordSuggestions {
                urlStr = urlStr! + "\(kDocTypeKeywordSuggestionsLabel)\(docType.resultsCount!)"
            }
            
            if let docType = suggestQuery.popularProducts {
                urlStr = urlStr! + "\(kDocTypePopularProductsLabel)\(docType.resultsCount!)"
                
                if let fields = docType.fields {
                    urlStr = urlStr! + "\(kDocTypePopularProductsFieldsLabel)\(fields.joined(separator: ","))"
                }
            }
        }
        
        return urlStr
    }
}
