//
//  Client.swift
//  UnbxdClient
//
//  Created by tilak kumar on 15/03/18.
//  Copyright © 2018 Unbxd Limited. All rights reserved.
//

import Foundation

public enum LoggingOption {
    case LogOff, LogDebug, LogError
}

public typealias CompletionHandler = (_ responseObject: Dictionary<String, Any>?,_ httpResponse: URLResponse?,_ error: Error?) -> Void

public class Client {
    public init?(siteKey: String, apiKey: String, logsOption: LoggingOption = .LogOff) {
        guard (!(siteKey).isEmpty) && (!(apiKey).isEmpty) else {
            return nil
        }
        Configuration.sharedConfiguration.siteKey = siteKey
        Configuration.sharedConfiguration.apiKey = apiKey
        Configuration.sharedConfiguration.logsOption = logsOption
    }
}

