//
//  NetworkOperation.swift
//  Unbxd
//
//  Created by tilak kumar on 27/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import UIKit
import Foundation

enum HttpMethodType: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

public class AsynchronousOperation : Operation {
    
    override public var isAsynchronous: Bool { return true }
    
    private let stateLock = NSLock()
    
    private var _executing: Bool = false
    override private(set) public var isExecuting: Bool {
        get {
            return stateLock.withCriticalScope { _executing }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            stateLock.withCriticalScope { _executing = newValue }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished: Bool = false
    override private(set) public var isFinished: Bool {
        get {
            return stateLock.withCriticalScope { _finished }
        }
        set {
            willChangeValue(forKey: "isFinished")
            stateLock.withCriticalScope { _finished = newValue }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    public func completeOperation() {
        if isExecuting {
            isExecuting = false
        }
        
        if !isFinished {
            isFinished = true
        }
    }
    
    override public func start() {
        if isCancelled {
            isFinished = true
            return
        }
        
        isExecuting = true
        
        main()
    }
    
    override public func main() {
        fatalError("subclasses must override `main`")
    }
}

extension NSLock {
    func withCriticalScope<T>( block: () -> T) -> T {
        lock()
        let value = block()
        unlock()
        return value
    }
}

class NetworkOperation: AsynchronousOperation {
    private let urlString: String
    private let httpMethod: HttpMethodType
    private let headers: Dictionary<String, String>?
    private var networkOperationCompletionHandler: ((_ responseObject: Dictionary<String,Any>?,_ httpResponse: URLResponse?, _ error: Error?) -> Void)?
    private var dataTask: URLSessionDataTask?
    
    init(urlString: String, method: HttpMethodType = .get, headers: Dictionary<String, String>? = nil , networkOperationCompletionHandler: ((_ responseObject: Dictionary<String,Any>?,_ httpResponse: URLResponse?,_ error: Error?) -> Void)? = nil) {
        self.urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        self.httpMethod = method
        self.headers = headers
        self.networkOperationCompletionHandler = networkOperationCompletionHandler
        super.init()
    }
    
    override func main() {
        Logger.logDebug("Requesting: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .current)
        let task = session.dataTask(with: request,
                                    completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data,
                  let resultJson = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                if let error {
                    Logger.logError(error.localizedDescription)
                }
                return
            }
            
            Logger.logDebug("RESPONSE: \(String(describing: response))")
            self?.networkOperationCompletionHandler?(resultJson, response, error)
            self?.networkOperationCompletionHandler = nil
            self?.completeOperation()
        })
        
        task.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
}
