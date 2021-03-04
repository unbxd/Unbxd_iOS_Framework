//
//  SearchRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 27/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class SearchRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    
    func parse(query: Any) -> String? {
        guard let searchQuery = query as? SearchQuery else {
            return nil
        }
        var urlStr = ClientRequestType.Search.baseUrl()
        
        if urlStr != nil {
            urlStr = urlStr! + "q=\(searchQuery.searchKey!)\(kVersionLabel)\(searchQuery.version)\(kResponseFormatLabel)\(searchQuery.responseFormat.rawValue)"
            
            // MARK: Adding Rows
            if let rows = searchQuery.rowsCount {
                urlStr = urlStr! + "\(kRowsLabel)\(rows)"
            }
            
            // MARK: Adding Start
            if let page = searchQuery.pageIndex {
                urlStr = urlStr! + "\(kStartLabel)\(page)"
            }
            
            // MARK: Adding Spell check
            if searchQuery.spellCheck {
                urlStr = urlStr! + "\(kSpellCheckLabel)\(String(searchQuery.spellCheck))"
            }
            
            // MARK: Adding Analytics
            if searchQuery.analytics {
                urlStr = urlStr! + "\(kAnalyticsEnabledLabel)\(String(searchQuery.analytics))"
            }
            
            // MARK: Adding Stats
            if let stats = searchQuery.showStatsForField {
                urlStr = urlStr! + "\(kStartLabel)\(stats)"
            }
            
            // MARK: Adding Variants
            if let variant = searchQuery.variant {
                urlStr = urlStr! + "\(kVariantEnabledLabel)\(String(variant.enabled))"

                if let count = variant.count {
                    urlStr = urlStr! + "\(kVariantCountLabel)\(count)"
                }
            }
            
            // MARK: Adding Fields
            if let fields = searchQuery.fields {
                urlStr = urlStr! + "\(kFieldsLabel)\(fields.joined(separator: ","))"
            }
            
            // MARK: Adding Facets
            if let facet = searchQuery.facet {
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
                                urlStr = urlStr! + "\(kIdFilterLabel)\(textFilter.field!):\"\(textFilter.value!)\""
                            }
                            else if textFilter is NameFilter {
                                urlStr = urlStr! + "\(kNameFilterLabel)\(textFilter.field!):\"\(textFilter.value!)\""
                            }
                        }
                        urlStr = urlStr! + "\(kSelectedFacetLabel)true"
                    }
                }
            }
            
            // MARK: Adding Filters
            if let filter = searchQuery.filter {
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
            if let cFilter = searchQuery.categoryFilter {
                if let cIdFilter = cFilter as? CategoryIdFilter {
                    urlStr = urlStr! + "\(kCategoryIdFilterLabel)\(cIdFilter.categories.joined(separator: ">"))"
                }
                else if let cIdFilter = cFilter as? CategoryNameFilter {
                    urlStr = urlStr! + "\(kCategoryPathFilterLabel)\(cIdFilter.categories.joined(separator: ">"))"
                }
            }
            
            // MARK: Adding Multiple Filters
            if let mFilter = searchQuery.multipleFilter {
                var filterStr = ""
                if mFilter.operatorType == .AND {
                    for case let filter as TextFilter in mFilter.filters {
                        if filter is IdFilter {
                            filterStr = filterStr + "\(kIdFilterLabel)\(filter.field!):\"\(filter.value!)\""
                        }
                        else if filter is NameFilter {
                            filterStr = filterStr + "\(kNameFilterLabel)\(filter.field!):\"\(filter.value!)\""
                        }
                    }
                    urlStr = urlStr! + "\(filterStr)"
                }
                else if mFilter.operatorType == .OR {
                    var fields = Array<String>()
                    for case let filter as TextFilter in mFilter.filters {
                        let fieldStr = "\(filter.field!):\"\(filter.value!)\""
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
            if let sortFields = searchQuery.fieldsSortOrder {
                var fieldsWithOrder = Array<String>()
                for case let sortField in sortFields {
                    let fieldStr = "\(sortField.field!) \(sortField.order.rawValue)"
                    fieldsWithOrder.append(fieldStr)
                }
                urlStr = urlStr! + "\(kSortLabel)\(fieldsWithOrder.joined(separator: "&"))"
            }
            
            if let personalized = searchQuery.personalization {
                urlStr = urlStr! + "\(kPersonalizationLabel)\(String(personalized))"
            }
        }
        
        return urlStr
    }
}
