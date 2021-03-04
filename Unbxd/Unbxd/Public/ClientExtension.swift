//
//  ClientExtension.swift
//  Unbxd
//
//  Created by tilak kumar on 21/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

extension Client {
    
    public func search(query:SearchQuery, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.search(query: query, completion: completion)
    }
    
    public func browse(query:BrowseQuery, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.browse(query: query, completion: completion)
    }
    
    public func autoSuggest(query:AutoSuggestQuery, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.autoSuggest(query: query, completion: completion)
    }
    
    public func track(analyticsDetails:AnalyticsAbstract, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.track(query: analyticsDetails, completion: completion)
    }
    
    public func recommend(recommendationQuery:RecommendationQuery, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.recommend(query: recommendationQuery, completion: completion)
    }
    
    public func search(productId: String, completion: @escaping CompletionHandler) {
        RequestHandler.sharedHandler.searchProduct(productId: productId, completion: completion)
    }
    
    public func userId() -> UserId {
        return UserIdHandler.userId
    }
    
}

