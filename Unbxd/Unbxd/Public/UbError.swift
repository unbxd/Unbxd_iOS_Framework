//
//  UbError.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

public enum UbError: Int, Error {
    case NetworkUnReachable, RequestTimeOut, FailedComposingUrl, EmptyResponse, FailedEncodingUrl, FailedParsingResponse
    
    public var errorMessage: String {
        switch self {
        case .FailedComposingUrl:
            return "Error while composing the request URL."
        case .FailedEncodingUrl:
            return "Error while encoding request URL."
        case .NetworkUnReachable:
            return "Network is unreachable, please check the connection."
        case .RequestTimeOut:
            return "Request time out, Please try again."
        case .EmptyResponse:
            return "No response from server."
        case .FailedParsingResponse:
            return "Error while paring response JSON."
        }
    }
    public var _code: Int { return self.rawValue }
}
