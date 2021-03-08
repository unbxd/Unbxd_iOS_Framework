//
//  RecommendationRequestBuilderV2.swift
//  Unbxd
//
//  Created by Tilak Kumar Gangadhar on 07/03/21.
//  Copyright © 2021 Unbxd Ltd. All rights reserved.
//

import Foundation

class RecommendationRequestBuilderV2: RequestBuilder, RequestBuilderProtocol {
    let kPageTypeLabel = "pageType="
    let kUIDLabel = "&uid="
    let kWidgetLabel = "&widget="
    let kBrandLabel = "&brand="
    let kProductLabel = "&id="
    let kIPLabel = "&ip="

    func parse(query: Any) -> String? {
        guard let recommedationInfo = query as? RecommendationsV2 else {
            return nil
        }
        var urlStr = ClientRequestType.RecommendV2.baseUrl()
        
        urlStr = urlStr! + "\(kPageTypeLabel)\(recommedationInfo.pageType.rawValue)"
        urlStr = urlStr! + "\(kUIDLabel)\(recommedationInfo.uid)"

        if let catLevels = recommedationInfo.categoryLevelNames {
            urlStr?.append("&")
            urlStr?.append(catLevels.enumerated().map { (index, catLevel) in
                return "catlevel\(index+1)Name=\(catLevel)"
            }.joined(separator: "&"))
        }
        
        if let pid = recommedationInfo.id {
            urlStr?.append("\(kProductLabel)\(pid)")
        }
        
        if let brand = recommedationInfo.brand {
            urlStr?.append("\(kBrandLabel)\(brand)")
        }
        
        if let ip = recommedationInfo.ip {
            urlStr?.append("\(kIPLabel)\(ip)")
        }
        
        if recommedationInfo.widget != .None {
            urlStr = urlStr! + "\(kWidgetLabel)\(recommedationInfo.widget.rawValue)"
        }

        return urlStr
    }
}
