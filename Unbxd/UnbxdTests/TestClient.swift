//
//  TestClient.swift
//  UnbxdTests
//
//  Created by tilak kumar on 15/04/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation
@testable import Unbxd

class TestClient {
    static let shared = TestClient()
    
    let client: Client
    
    init() {
        
        //Unilever
        client = Client(siteKey: "meumercadoemcasa-dev8551606126125", apiKey: "59fac16520048dbdd08ce535447f3b9f", logsOption: .LogDebug)!

        //client = Client(siteKey: "demo-unbxd700181503576558", apiKey: "fb853e3332f2645fac9d71dc63e09ec1", logsOption: .LogDebug)!
        //client = Client(siteKey: "demosite-u1407617955968", apiKey: "64a4a2592a648ac8415e13c561e44991", logsOption: .LogDebug)!
        //client = Client(siteKey: "docs-unbxd700181508846765", apiKey: "63e6578fcb4382aee0eea117aba3a227", logsOption: .LogDebug)!
        //client = Client(siteKey: "homecategory-unbxdapi-com700891527665816", apiKey: "3de5072141b3ac53b1963b83e3e8cbe2", logsConfig: LogsConfig(logLevel: .all, folderPath: nil))!
    }
}
