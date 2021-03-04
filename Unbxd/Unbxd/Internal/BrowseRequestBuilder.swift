//
//  BrowseRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 21/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

let kDoubleQuoteSymbol = "%22"
let kGreaterThanSymbol = "%3E"
let kPageTypeLabel = "&pagetype="

class BrowseRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    
    func parse(query: Any) -> String? {
        guard let browseQuery = query as? BrowseQuery else {
            return nil
        }
        var urlStr = ClientRequestType.Browse.baseUrl()
        
        if urlStr != nil {
            
            guard let categoryInfo = browseQuery.browseCategoryQuery else {
                return nil
            }
            
            switch categoryInfo {
                case let categoryIdPath as CategoryIdPath: do {
                    if let categoryPath = categoryIdPath.path {
                        urlStr = urlStr! + "pid=categoryPathId:\(categoryPath)"
                    }
                }
                case let categoryNamePath as CategoryNamePath: do {
                    if let categoryPath = categoryNamePath.path {
                        urlStr = urlStr! + "p=\(categoryPath)"
                    }
                }
                case let categoryIdField as CategoryIdField: do {
                    urlStr = urlStr! + "pid=\(categoryIdField.field!):\(categoryIdField.value!)"
                }
                case let categoryNameField as CategoryNameField: do {
                    urlStr = urlStr! + "p=\(categoryNameField.field!):\(categoryNameField.value!)"
                }
                default: do {
                    Logger.logError("Unknown category type")
                }
            }
            
            if let pageType = browseQuery.pageType {
                urlStr = urlStr! + kPageTypeLabel + pageType.rawValue.lowercased();
            }
            
            urlStr = urlStr! + "\(kVersionLabel)\(browseQuery.version)\(kResponseFormatLabel)\(browseQuery.responseFormat.rawValue)"

            // MARK: Adding Rows
            if let rows = browseQuery.rowsCount {
                urlStr = urlStr! + "\(kRowsLabel)\(rows)"
            }
            
            // MARK: Adding Start
            if let page = browseQuery.pageIndex {
                urlStr = urlStr! + "\(kStartLabel)\(page)"
            }
            
            // MARK: Adding Spell check
            if browseQuery.spellCheck {
                urlStr = urlStr! + "\(kSpellCheckLabel)\(String(browseQuery.spellCheck))"
            }
            
            // MARK: Adding Analytics
            if browseQuery.analytics {
                urlStr = urlStr! + "\(kAnalyticsEnabledLabel)\(String(browseQuery.analytics))"
            }
            
            // MARK: Adding Stats
            if let stats = browseQuery.showStatsForField {
                urlStr = urlStr! + "\(kStartLabel)\(stats)"
            }
            
            // MARK: Adding Variants
            if let variant = browseQuery.variant {
                urlStr = urlStr! + "\(kVariantEnabledLabel)\(String(variant.enabled))"
                
                if let count = variant.count {
                    urlStr = urlStr! + "\(kVariantCountLabel)\(count)"
                }
            }
            
            // MARK: Adding Fields
            if let fields = browseQuery.fields {
                urlStr = urlStr! + "\(kFieldsLabel)\(fields.joined(separator: ","))"
            }
            
            // MARK: Adding Facets
            if let facet = browseQuery.facet {
                switch facet {
                case .MultiLevel: do {
                    urlStr = urlStr! + "\(kMultiLevelFacetLabel)categoryPath"
                    }
                case .MultiSelect: do {
                    urlStr = urlStr! + "\(kMultiSelectFacetLabel)true"
                    }
                case .Selected(let filter): do {
                    if let textFilter = filter as? TextFilter {
                        if textFilter is IdFilter {
                            urlStr = urlStr! + "\(kIdFilterLabel)\(textFilter.field!):\(textFilter.value!)"
                        }
                        else if textFilter is NameFilter {
                            urlStr = urlStr! + "\(kNameFilterLabel)\(textFilter.field!):\(textFilter.value!)"
                        }
                    }
                    urlStr = urlStr! + "\(kSelectedFacetLabel)true"
                    }
                }
            }
            
            // MARK: Adding Filters
            if let filter = browseQuery.filter {
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
            
            // MARK: Adding Category Filters
            if let cFilter = browseQuery.categoryFilter {
                if let cIdFilter = cFilter as? CategoryIdFilter {
                    urlStr = urlStr! + "\(kCategoryIdFilterLabel)\(cIdFilter.categories.joined(separator: ">"))"
                }
                else if let cIdFilter = cFilter as? CategoryNameFilter {
                    urlStr = urlStr! + "\(kCategoryPathFilterLabel)\(cIdFilter.categories.joined(separator: ">"))"
                }
            }
            
            // MARK: Adding Multiple Filters
            if let mFilter = browseQuery.multipleFilter {
                var filterStr = ""
                if mFilter.operatorType == .AND {
                    for case let filter as TextFilter in mFilter.filters {
                        if filter is IdFilter {
                            filterStr = filterStr + "\(kIdFilterLabel)\(filter.field!):\(filter.value!)"
                        }
                        else if filter is NameFilter {
                            filterStr = filterStr + "\(kNameFilterLabel)\(filter.field!):\(filter.value!)"
                        }
                    }
                    urlStr = urlStr! + "\(filterStr)"
                }
                else if mFilter.operatorType == .OR {
                    var fields = Array<String>()
                    for case let filter as TextFilter in mFilter.filters {
                        let fieldStr = "\(filter.field!):\(filter.value!)"
                        fields.append(fieldStr)
                    }
                    if mFilter is MultipleIdFilter {
                        urlStr = urlStr! + "\(kIdFilterLabel)(\(fields.joined(separator: " OR ")))"
                    }
                    else if mFilter is MultipleNameFilter {
                        urlStr = urlStr! + "\(kNameFilterLabel)(\(fields.joined(separator: " OR ")))"
                        
                    }
                }
            }
            
            // MARK: Adding Sort
            if let sortFields = browseQuery.fieldsSortOrder {
                var fieldsWithOrder = Array<String>()
                for case let sortField in sortFields {
                    let fieldStr = "\(sortField.field!) \(sortField.order.rawValue)"
                    fieldsWithOrder.append(fieldStr)
                }
                urlStr = urlStr! + "\(kSortLabel)\(fieldsWithOrder.joined(separator: "&"))"
            }
            
            if let personalized = browseQuery.personalization {
                urlStr = urlStr! + "\(kPersonalizationLabel)\(String(personalized))"
            }
        }
        
        return urlStr
    }
}
