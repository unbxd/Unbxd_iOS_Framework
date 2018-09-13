//
//  Client.swift
//  UnbxdClient
//
//  Created by tilak kumar on 15/03/18.
//  Copyright © 2018 Unbxd Limited. All rights reserved.
//

import Foundation
import CocoaLumberjack

public typealias CompletionHandler = (_ responseObject: Dictionary<String, Any>?,_ httpResponse: HTTPURLResponse?,_ error: Error?) -> Void

public class Client {
    public init?(siteKey: String, apiKey: String, logsConfig: LogsConfig = LogsConfig()) {
        guard (!(siteKey).isEmpty) && (!(apiKey).isEmpty) else {
            DDLogError("Error; Initializing failed")        
            return nil
        }
        Configuration.sharedConfiguration.siteKey = siteKey
        Configuration.sharedConfiguration.apiKey = apiKey
        
        DDLog.add(DDTTYLogger.sharedInstance, with: logsConfig.logLevel)

        if let logsFolderPath = logsConfig.logFolderPath {
            let fileLogManager = DDLogFileManagerDefault.init(logsDirectory: logsFolderPath, defaultFileProtectionLevel: .none)
            let fileLogger = DDFileLogger.init(logFileManager: fileLogManager)
            fileLogger!.rollingFrequency = TimeInterval(60*60*24)
            DDLog.add(fileLogger!, with: logsConfig.logLevel)
        }
        
        DDLogInfo("Client intialized")
    }
}

