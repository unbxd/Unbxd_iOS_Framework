//
//  Logger.swift
//  Unbxd
//
//  Created by Tilak Kumar on 14/03/20.
//  Copyright © 2020 Unbxd Ltd. All rights reserved.
//

import Foundation

class Logger {
    class func logDebug(_ message: String) {
        let option = Configuration.sharedConfiguration.logsOption
        if option == .LogDebug {
            print(message)
        }
    }
    
    class func logError(_ message: String) {
        let option = Configuration.sharedConfiguration.logsOption
        if option == .LogError || option == .LogDebug {
            print(message)
        }

    }
}
