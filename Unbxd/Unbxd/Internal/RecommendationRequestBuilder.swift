//
//  RecommendationRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 14/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class RecommendationRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    let kPageTypeLabel = "pageType="
    let kRegionLabel = "&region="
    let kCurrencyLabel = "&currency="
    let kWidgetLabel = "&widget="
    let kBrandLabel = "&brand="
    let kProductLabel = "&id="
    let kUIDLabel = "uid="

    func parse(query: Any) -> String? {
        guard let recommedationInfo = query as? RecommendationQuery else {
            return nil
        }
        var urlStr: String?
        if recommedationInfo.version == .Version2 {
            urlStr = ClientRequestType.RecommendV2.baseUrl()
        }
        else {
            urlStr = ClientRequestType.Recommend.baseUrl()
        }
        

        switch recommedationInfo {
            case let queryRef as RecommendedForYourRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                
                urlStr = urlStr! + "\(queryRef.uid)/?"
            }
            case let queryRef as RecentlyViewedRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
            
                urlStr = urlStr! + "\(queryRef.uid)/?"
            }
            case let queryRef as MoreLikeThisRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
            
                if let pid = queryRef.pid {
                    urlStr = urlStr! + "\(pid)/?"
                }
                
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as ViewedAlsoViewedRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
            
                if let pid = queryRef.pid {
                    urlStr = urlStr! + "\(pid)/?"
                }
            
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as BoughtAlsoBoughtRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
            
                if let pid = queryRef.pid {
                    urlStr = urlStr! + "\(pid)/?"
                }
            
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as CartRecomendations: do {
                if (recommedationInfo.version == .Version2) {
                    urlStr = urlStr! + "\(kPageTypeLabel)\(RecsV2PageType.Cart.rawValue)&"
                    urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
                }
                else {
                    urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                    urlStr = urlStr! + "\(queryRef.uid)/?"
                }
            }
            case let queryRef as HomePageTopSellersRecomendations: do {
                if (recommedationInfo.version == .Version2) {
                    urlStr = urlStr! + "\(kPageTypeLabel)\(RecsV2PageType.Home.rawValue)&"
                }
                else {
                    urlStr = urlStr! + "\(queryRef.type.rawValue)/?"
                }
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as CategoryTopSellersRecomendations: do {
                
                if (recommedationInfo.version == .Version2) {
                    urlStr = urlStr! + "\(kPageTypeLabel)\(RecsV2PageType.Category.rawValue)&"
                    if let catLevels = queryRef.categoryLevelNames {
                        for (index, catLevel) in catLevels.enumerated() {
                            urlStr = urlStr! + "catlevel\(index+1)Name=\(catLevel)"
                            urlStr?.append("&")
                        }
                    }
                    urlStr?.append("\(kUIDLabel)\(queryRef.uid)")
                }
                else {
                    urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                    if let category = queryRef.category {
                        urlStr = urlStr! + "\(category)?"
                    }
                }
            
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as PDPTopSellersRecomendations: do {
                if (recommedationInfo.version == .Version2) {
                    urlStr = urlStr! + "\(kPageTypeLabel)\(RecsV2PageType.Pdp.rawValue)"
                    urlStr?.append("\(kProductLabel)\(queryRef.pid)&")
                }
                else {
                    urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                    urlStr = urlStr! + "\(queryRef.pid)/?"
                }

                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"

            }
            case let queryRef as BrandTopSellersRecomendations: do {
                if (recommedationInfo.version == .Version2) {
                    urlStr = urlStr! + "\(kPageTypeLabel)\(RecsV2PageType.Brand.rawValue)"
                    urlStr?.append("\(kBrandLabel)\(queryRef.brand)&")
                }
                else {
                    urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                    urlStr = urlStr! + "\(queryRef.brand)/?"
                }

            
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as CompleteTheLookRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                urlStr = urlStr! + "\(queryRef.pid)/?"
                urlStr = urlStr! + "\(queryRef.uid)"
            }
            default: do {
                Logger.logError("Invlaid recommendation type")
            }
        }
        
        urlStr = urlStr! + "\(kResponseFormatLabel)\(recommedationInfo.responseFormat.rawValue)"
        
        if let region = recommedationInfo.region {
            urlStr = urlStr! + "\(kRegionLabel)\(region)"
        }
        
        if let crFrmt = recommedationInfo.currencyFormat {
            urlStr = urlStr! + "\(kCurrencyLabel)\(crFrmt)"
        }
        
        if recommedationInfo.widget != .None {
            urlStr = urlStr! + "\(kWidgetLabel)\(recommedationInfo.widget.rawValue)"
        }

        return urlStr
    }
}
