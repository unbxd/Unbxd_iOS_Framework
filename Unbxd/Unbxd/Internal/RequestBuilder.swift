//
//  RequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 27/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

protocol RequestBuilderProtocol {
    func parse(query: Any) -> String?;
}

class RequestBuilder {
    let kVersionLabel = "&version="
    let kResponseFormatLabel = "&format="
    let kRowsLabel = "&rows="
    let kStartLabel = "&start="
    let kVariantEnabledLabel = "&variants="
    let kVariantCountLabel = "&variant.count="
    let kSpellCheckLabel = "&spellcheck="
    let kAnalyticsEnabledLabel = "&analytics="
    let kFieldsLabel = "&fields="
    let kMultiSelectFacetLabel = "&facet.multiselect="
    let kMultiLevelFacetLabel = "&facet.multilevel="
    let kSelectedFacetLabel = "&selectedfacet="
    let kIdFilterLabel = "&filter-id="
    let kNameFilterLabel = "&filter="
    let kCategoryIdFilterLabel = "&category-filter-id="
    let kCategoryPathFilterLabel = "&category-filter="
    let kSortLabel = "&sort="
    let kPersonalizationLabel = "&personalization="
}

enum ClientRequestType {
    case Search, Browse, AutoSuggest, Analytics, Recommend, RecommendV2, SearchProduct
    
    func baseUrl() -> String? {
        let config = Configuration.sharedConfiguration
        switch self {
        case .Search:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kSearchBaseUrlKey))
        case .Browse:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kBrowseBaseUrlKey))
        case .AutoSuggest:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kAutoSuggestBaseUrlKey))
        case .Analytics:
            return self.baseUrlFromPlist(key: Constants.kAnalyticsUrlKey)
        case .Recommend:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kRecommendBaseUrlKey))
        case .RecommendV2:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kRecommendV2BaseUrlKey))
        case .SearchProduct:
            return self.add(configuration: config, to: self.baseUrlFromPlist(key: Constants.kSearchProductBaseUrlKey))
        }
    }
    
    fileprivate func baseUrlFromPlist(key:String) -> String? {
        if let URL = Bundle(for: RequestBuilder.self).url(forResource: "URLConfiguration", withExtension: "plist") {
            if let fileContent = NSDictionary(contentsOf: URL) as? [String: Any] {
                if let value = fileContent[key] as? String {
                    return value
                }
            }
        }
        
        return nil
    }
    
    func add(configuration:Configuration, to baseUrl:String?) -> String? {
        guard let url = baseUrl else {
            return nil
        }
        var result = url.replacingOccurrences(of: Constants.kAPIKey, with: configuration.apiKey!)
        result = result.replacingOccurrences(of: Constants.kSiteKey, with: configuration.siteKey!)
        return result
    }
}
