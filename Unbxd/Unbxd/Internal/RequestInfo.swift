//
//  RequestInfo.swift
//  Unbxd
//
//  Created by tilak kumar on 15/02/19.
//  Copyright © 2019 Unbxd Ltd. All rights reserved.
//

import UIKit

protocol RequestInfoProtocol {
    var requestUrlString: String {get}
    var authNeeded: Bool {get}
}

final class RequestInfo: RequestInfoProtocol {
    var requestUrlString: String
    var authNeeded: Bool

    required init(urlString: String, auth: Bool) {
        self.requestUrlString = urlString
        self.authNeeded = auth
    }
}
