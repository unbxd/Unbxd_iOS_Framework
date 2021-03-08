//
//  RecommendationRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 14/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class RecommendationRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    let kRegionLabel = "&region="
    let kCurrencyLabel = "&currency="
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
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                urlStr = urlStr! + "\(queryRef.uid)/?"
            }
            case let queryRef as HomePageTopSellersRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/?"

                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as CategoryTopSellersRecomendations: do {
                
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                if let category = queryRef.category {
                    urlStr = urlStr! + "\(category)?"
                }
            
                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as PDPTopSellersRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                urlStr = urlStr! + "\(queryRef.pid)/?"

                urlStr = urlStr! + "\(kUIDLabel)\(queryRef.uid)"
            }
            case let queryRef as BrandTopSellersRecomendations: do {
                urlStr = urlStr! + "\(queryRef.type.rawValue)/"
                urlStr = urlStr! + "\(queryRef.brand)/?"
                
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

        return urlStr
    }
}
