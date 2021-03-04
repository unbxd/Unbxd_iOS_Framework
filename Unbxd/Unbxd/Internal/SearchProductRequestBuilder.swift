//
//  SearchProductRequestBuilder.swift
//  Unbxd
//
//  Created by tilak kumar on 23/06/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit

class SearchProductRequestBuilder: RequestBuilder, RequestBuilderProtocol {
    func parse(query: Any) -> String? {
        guard let productId = query as? String else {
            return nil
        }
        var urlStr = ClientRequestType.SearchProduct.baseUrl()
        urlStr?.append(productId)
        return urlStr
    }
}
