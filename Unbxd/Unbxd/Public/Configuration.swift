//
//  Configuration.swift
//  Unbxd
//
//  Created by tilak kumar on 27/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

class Configuration {
    static let sharedConfiguration = Configuration()
    
    /// Site key supplied with SDK
    var siteKey: String?
    
    /// Api key supplied with SDK
    var apiKey: String?
    
    /// Logging Option
    var logsOption: LoggingOption?
}
