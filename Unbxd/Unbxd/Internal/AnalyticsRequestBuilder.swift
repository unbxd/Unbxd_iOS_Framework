//
//  AnalyticsRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 04/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class AnalyticsRequestBuilder: RequestBuilder {
    let kDoubleQuoteSymbol = "%22"
    let kAnalyticsUnbxdKeyLabel = "UnbxdKey="
    let kAnalyticsActionLabel = "&action="
    let kAnalyticsUidLabel = "&uid="
    let kAnalyticsVisitTypeLabel = "\"visit_type\":"
    let kAnalyticsQueryLabel = "\"query\":"
    let kAnalyticsPageLabel = "\"page\":"
    let kAnalyticePagePathLabel = "\"page_type\":"
    let kAnalyticsPIDLabel = "\"pid\":"
    let kAnalyticsVerLabel = "\"ver\":"
    let kAnalyticsVariantIdLabel = "\"variantId\":"
    let kAnalyticsQtyLabel = "\"qty\":"
    let kAnalyticsPriceLabel = "\"price\":"
    let kAutoSuggestDataLabel = "\"autosuggest_data\":"
    let kAutoSuggestTypeLabel = "\"autosuggest_type\":"
    let kAutoSuggestSuggestionLabel = "\"autosuggest_suggestion\":"
    let kAutoSuggestFieldValueLabel = "\"field_value\":"
    let kAutoSuggestFieldNameLabel = "\"field_name\":"
    let kAutoSuggestSrcFieldLabel = "\"src_field\":"
    let kAutoSuggesPrankFieldLabel = "\"unbxdprank\":"
    let kAutoSuggestInternalQueryLabel = "\"internal_query\":"
    let kAutoSuggestBoxTypeLabel = "\"box_type\":"
    let kExperiencePageType = "\"experience_pagetype\":"
    let kExperienceWidgetType = "\"experience_widget\":"
    let kIdentifier = "\"identifier\":"
    let kAutoSuggestPidsLabel = "\"pids_list\":"
    let kAnalyticePageURLLabel = "\"page_type\":\"URL\""
    let kAnalyticsDwellTimeLabel = "\"dwellTime\":"
    let kAnalyticsFacetsLabel = "\"facets\":"
    let kAnalyticsDataKey = "data="
    let kRequestIdKey = "\"unbxd-request-id\":"

    func parse(query: Any) -> String? {
        guard let analyticsInfo = query as? AnalyticsAbstract else {
            return nil
        }
        var urlStr = ClientRequestType.Analytics.baseUrl()
        
        let version = "2.8.22.1"
        
        if urlStr != nil {
            var dataStr = ""
            var dataComponents = Array<String>()
            dataComponents.append("\"ver\":\"\(version)\"")
            dataComponents.append("\(kRequestIdKey)\"\(analyticsInfo.requestId)\"")
            dataComponents.append("\(kAnalyticsVisitTypeLabel)\"\(analyticsInfo.visitType)\"")
            
            switch analyticsInfo {
            case _ as VisitorAnalytics: do {
                
                
            }
            case let searchInfo as SearchAnalytics : do {
                
                if let searchKey = searchInfo.searchKey {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(searchKey)\"")
                }
                
                
            }
            case let categoryAnalytics as CategoryPageAnalytics : do {
                
                if let categoryPath = categoryAnalytics.categoryInfo?.path {
                    dataComponents.append("\(kAnalyticsPageLabel)\"\(categoryPath)\"")
                }
                else {
                    Logger.logError("CategoryPageAnalytics: category path is empty!")
                }
                
                if let pageType = categoryAnalytics.pageType {
                    dataComponents.append("\(kAnalyticePagePathLabel)\"\(pageType.rawValue)\"")
                }
            }
            case let productClickInfo as ProductClickAnalytics : do {
                
                if let productId = productClickInfo.pID {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let query = productClickInfo.query {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(query)\"")
                }
                
                if let boxType = productClickInfo.boxType {
                    dataComponents.append("\(kAutoSuggestBoxTypeLabel)\"\(boxType)\"")
                }
                
                
            }
            case let productClickInfo as ProductClickAnalyticsV2 : do {
                
                if let productId = productClickInfo.pID {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let query = productClickInfo.query {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(query)\"")
                }
                
                if let pageType = productClickInfo.pageType {
                    dataComponents.append("\(kExperiencePageType)\"\(pageType)\"")
                }
                
                if let widget = productClickInfo.widget {
                    dataComponents.append("\(kExperienceWidgetType)\"\(widget.rawValue)\"")
                }
                
            }
            case let addToCartInfo as ProductAddToCartAnalytics : do {                
                
                if let productId = addToCartInfo.productId {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let variantId = addToCartInfo.variantId {
                    dataComponents.append("\(kAnalyticsVariantIdLabel)\"\(variantId)\"")
                }
                
                if let qty = addToCartInfo.qty {
                    dataComponents.append("\(kAnalyticsQtyLabel)\"\(qty)\"")
                }
                
                
            }
            case let productOrderInfo as ProductOrderAnalytics : do {
                
                if let productId = productOrderInfo.productId {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let price = productOrderInfo.price {
                    dataComponents.append("\(kAnalyticsPriceLabel)\"\(price)\"")
                }
                
                if let qty = productOrderInfo.qty {
                    dataComponents.append("\(kAnalyticsQtyLabel)\"\(qty)\"")
                }
                
                
            }
            case let productDisplayInfo as ProductDisplayPageViewAnalytics : do {
                
                if let productId = productDisplayInfo.skuId {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                
            }
            case let cartRemovalInfo as CartRemovalAnalytics : do {
                
                if let productId = cartRemovalInfo.skuId {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let variantId = cartRemovalInfo.variantId {
                    dataComponents.append("\(kAnalyticsVariantIdLabel)\"\(variantId)\"")
                }
                
                if let qty = cartRemovalInfo.qty {
                    dataComponents.append("\(kAnalyticsQtyLabel)\"\(qty)\"")
                }
                
                
            }
            case let autoSuggestInfo as AutoSuggestAnalytics : do {
              
                if let query = autoSuggestInfo.query {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(query)\"")
                }
                
                var autoSuggestDataStr = ""
                var autoSuggestDataArr = Array<String>()
                if let docType = autoSuggestInfo.docType {
                    autoSuggestDataArr.append("\(kAutoSuggestTypeLabel)\"\(docType)\"")
                }
                
                autoSuggestDataArr.append("\(kAutoSuggestSuggestionLabel)\"\(autoSuggestInfo.query!)\"")
                
                if let fValue = autoSuggestInfo.fieldValue {
                    autoSuggestDataArr.append("\(kAutoSuggestFieldValueLabel)\"\(fValue)\"")
                }
                
                if let fName = autoSuggestInfo.fielName {
                    autoSuggestDataArr.append("\(kAutoSuggestFieldNameLabel)\"\(fName)\"")
                }
                
                if let srcField = autoSuggestInfo.srcField {
                    autoSuggestDataArr.append("\(kAutoSuggestSrcFieldLabel)\"\(srcField)\"")
                }
                
                if let uPrank = autoSuggestInfo.unbxdPrank {
                    autoSuggestDataArr.append("\(kAutoSuggesPrankFieldLabel)\(uPrank)")
                }
                
                if let iQuery = autoSuggestInfo.intQuery {
                    autoSuggestDataArr.append("\(kAutoSuggestInternalQueryLabel)\"\(iQuery)\"")
                }
                if autoSuggestDataArr.count > 0 {
                    autoSuggestDataStr = autoSuggestDataStr + "\(kAutoSuggestDataLabel){\(autoSuggestDataArr.joined(separator: ","))}"
                }
                
                dataComponents.append(autoSuggestDataStr)
                
                
            }
            case let recommendationInfo as RecommendationWidgetAnalytics : do {
                
                dataComponents.append("\(kAutoSuggestBoxTypeLabel)\"\(recommendationInfo.recommendationType.analyticsBoxType())\"")
                
                var pidsStr = ""
                var pidArr = Array<String>()
                
                for pid in recommendationInfo.pids! {
                    pidArr.append("\"\(pid)\"")
                }
                if pidArr.count > 0 {
                    pidsStr = pidsStr + "\(pidArr.joined(separator: ","))"
                }
                
                dataComponents.append("\(kAutoSuggestPidsLabel)[\(pidsStr)]")
            }
            case let recommendationInfo as RecommendationWidgetAnalyticsV2 : do {
                
                dataComponents.append("\(kExperiencePageType)\"\(recommendationInfo.pageType.rawValue)\"")
                
                if let widget = recommendationInfo.widget {
                    dataComponents.append("\(kExperienceWidgetType)\"\(widget.rawValue)\"")
                }
                
                if let id = recommendationInfo.identifier {
                    dataComponents.append("\(kIdentifier)\"\(id)\"")
                }
                
                var pidsStr = ""
                var pidArr = Array<String>()
                
                for pid in recommendationInfo.pids! {
                    pidArr.append("\"\(pid)\"")
                }
                if pidArr.count > 0 {
                    pidsStr = pidsStr + "\(pidArr.joined(separator: ","))"
                }
                
                dataComponents.append("\(kAutoSuggestPidsLabel)[\(pidsStr)]")
            }
            case let searchImpressionInfo as SearchImpressionAnalytics : do {
                
                if let query = searchImpressionInfo.query {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(query)\"")
                }
                
                var pidsStr = ""
                var pidArr = Array<String>()
                
                for pid in searchImpressionInfo.pids! {
                    pidArr.append("\"\(pid)\"")
                }
                if pidArr.count > 0 {
                    pidsStr = pidsStr + "\(pidArr.joined(separator: ","))"
                }
                
                dataComponents.append("\(kAutoSuggestPidsLabel)[\(pidsStr)]")
                
                
            }
            case let pageImpressionInfo as CategoryPageImpressionAnalytics : do {
                
                if let categoryPath = pageImpressionInfo.categoryInfo?.path {
                    dataComponents.append("\(kAnalyticsPageLabel)\"\(categoryPath)\"")
                }
                
                if let pageType = pageImpressionInfo.pageType {
                    dataComponents.append("\(kAnalyticePagePathLabel)\"\(pageType.rawValue)\"")
                }
                
                var pidsStr = ""
                var pidArr = Array<String>()
                
                for pid in pageImpressionInfo.pids! {
                    pidArr.append("\"\(pid)\"")
                }
                if pidArr.count > 0 {
                    pidsStr = pidsStr + "\(pidArr.joined(separator: ","))"
                }
                
                dataComponents.append("\(kAutoSuggestPidsLabel)[\(pidsStr)]")
                
                
            }
            case let dwellTimeInfo as DwellTimeAnalytics : do {
                dataStr = dataStr + "{\(kAnalyticsPIDLabel)\"\(dwellTimeInfo.productId!)\",\(kAnalyticsDwellTimeLabel)\(dwellTimeInfo.time!)}"
                
                if let productId = dwellTimeInfo.productId {
                    dataComponents.append("\(kAnalyticsPIDLabel)\"\(productId)\"")
                }
                
                if let time = dwellTimeInfo.time {
                    dataComponents.append("\(kAnalyticsDwellTimeLabel)\"\(time)\"")
                }                
            }
            case let facetInfo as FacetAnalytics : do {
                
                if let query = facetInfo.query {
                    dataComponents.append("\(kAnalyticsQueryLabel)\"\(query)\"")
                }
                
                var fieldsStr = ""
                var fieldsArr = Array<String>()
                
                switch facetInfo.fields
                {
                    case let nameFilter as TextFilter : do {
                        fieldsArr.append("\"\(nameFilter.field!)\":[\"\(nameFilter.value!)\"]")
                    }
                    default: do {
                    
                    }
                }
                
            
                if fieldsArr.count > 0 {
                    fieldsStr = fieldsStr + "\(fieldsArr.joined(separator: ","))"
                }
                
                dataComponents.append("\(kAnalyticsFacetsLabel)[\(fieldsStr)]")
            }
            default:
                Logger.logError("Unknown Analtytics type")
            }
            
            if dataComponents.count > 0 {
                dataStr = dataStr + "{\(dataComponents.joined(separator: ","))}"
            }
            
            if let sKey = Configuration.sharedConfiguration.siteKey {
                urlStr = urlStr! + "\(kAnalyticsUnbxdKeyLabel)\(sKey)" + "\(kAnalyticsActionLabel)\(analyticsInfo.actionType.rawValue)" + "\(kAnalyticsUidLabel)\(analyticsInfo.uid)"

            }
            
            if dataStr.count > 0 {
                urlStr = urlStr! + "&\(kAnalyticsDataKey)\(dataStr)"
            }
        }
        
        return urlStr
    }
}
