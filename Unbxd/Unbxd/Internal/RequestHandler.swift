//
//  RequestHandler.swift
//  Unbxd
//
//  Created by tilak kumar on 27/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

class RequestHandler {
    static let sharedHandler = RequestHandler()
    
    private let queue: OperationQueue
    private let visitorEventHandler: VisitorEventHandler
    
    private init() {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        visitorEventHandler = VisitorEventHandler()
    }
    
    fileprivate func process(request:RequestInfoProtocol, completion: @escaping CompletionHandler) {
        if NetworkCheck.isConnectedToNetwork() {
            if let encodedUrl = request.requestUrlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) {
                var headers = self.deviceTypeHeader()
                if request.authNeeded == true {
                    headers = addAuthToHeader(headers: headers)
                }
                let operation = NetworkOperation(urlString:encodedUrl, headers: headers) { [weak self] responseObject, httpResponse, error in
                    if (error != nil) {
                        Logger.logError(error.debugDescription)
                    }
                    else if responseObject == nil {
                        Logger.logError("Internal Error: Empty response!")
                        let err = UbError.EmptyResponse
                        completion(responseObject, httpResponse, err)
                    }
                    completion(responseObject, httpResponse, error)
                    
                    DispatchQueue.global().async(execute: {
                        self?.visitorEventHandler.httpResponse = httpResponse as? HTTPURLResponse
                        self?.visitorEventHandler.checkIfVisitorEventToBeSent()
                    })
                }
                queue.addOperation(operation)
            }
            else {
                Logger.logError("Internal Error: Failed encoding URL!")
                let err = UbError.FailedEncodingUrl
                completion(nil,nil,err)
            }
        }
        else {
            Logger.logError("Error: Network unreacheble, please check the connectivity!")
            let err = UbError.NetworkUnReachable
            completion(nil,nil,err)
        }
    }
    
    internal func search(query:SearchQuery, completion: @escaping CompletionHandler) {
        
        let requestBuilder = SearchRequestBuilder()
        
        if let urlString = requestBuilder.parse(query: query) {
            let requestInfo = RequestInfo(urlString: urlString, auth: false)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    internal func browse(query:BrowseQuery, completion: @escaping CompletionHandler) {
        
        let requestBuilder = BrowseRequestBuilder()
        
        if let urlString = requestBuilder.parse(query: query) {
            let requestInfo = RequestInfo(urlString: urlString, auth: false)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    internal func autoSuggest(query:AutoSuggestQuery, completion: @escaping CompletionHandler) {
        
        let requestBuilder = AutoSuggestRequestBuilder()
        
        if let urlString = requestBuilder.parse(query: query) {
            let requestInfo = RequestInfo(urlString: urlString, auth: false)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    internal func track(query:AnalyticsAbstract, completion: @escaping CompletionHandler) {
        
        let requestBuilder = AnalyticsRequestBuilder()
        
        if let urlString = requestBuilder.parse(query: query)  {
            let requestInfo = RequestInfo(urlString: urlString, auth: false)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    internal func recommend(query:RecommendationQuery, completion: @escaping CompletionHandler) {
        
        let requestBuilder: RequestBuilderProtocol
        
        if (query.version == .Version2) {
            requestBuilder = RecommendationRequestBuilderV2()
        }
        else {
            requestBuilder = RecommendationRequestBuilder()
        }
        
        if let urlString = requestBuilder.parse(query: query) {
            let requestInfo = RequestInfo(urlString: urlString, auth: false)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    internal func searchProduct(productId:String, completion: @escaping CompletionHandler) {
        
        let requestBuilder = SearchProductRequestBuilder()
        
        if let urlString = requestBuilder.parse(query: productId) {
            let requestInfo = RequestInfo(urlString: urlString, auth: true)
            self.process(request: requestInfo, completion: completion)
        }
        else {
            Logger.logError("Internal Error: Failed composing URL!")
            let err = UbError.FailedComposingUrl
            completion(nil,nil,err)
        }
    }
    
    fileprivate func deviceTypeHeader() -> [String:String] {
        let deviceType = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? "mobile" : "tablet"
        let osType = "ios"
        let sourceType = "app"
        
        let infoDictionary = Bundle.main.infoDictionary!
        
        let appName = infoDictionary["CFBundleName"] ?? ""
        let version = infoDictionary["CFBundleShortVersionString"] ?? ""
        let devicePlatform = UIDevice.current.name
        var model = UIDevice().model
        model = model.replacingOccurrences(of: ".", with: "_")

        var osVersion = UIDevice.current.systemVersion
        osVersion = osVersion.replacingOccurrences(of: ".", with: "_")
        return ["unbxd-device-type":"{\"type\":\"\(deviceType)\",\"os\":\"\(osType)\",\"source\":\"\(sourceType)\"}", "User-Agent":"\(appName)/\(version) \(devicePlatform)/\(model) iOS/\(osVersion) CFNetwork/758.0.2 Darwin/15.0.0"]
    }
    
    fileprivate func addAuthToHeader(headers:[String:String]) -> [String:String] {
        var updatedHeaders = [String: String]()
        updatedHeaders["Authorization"] = Configuration.sharedConfiguration.apiKey
        updatedHeaders.merge(dict: headers)
        return updatedHeaders
    }
}
