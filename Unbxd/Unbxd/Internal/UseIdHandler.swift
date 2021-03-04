//
//  UseIdHandler.swift
//  Unbxd
//
//  Created by tilak kumar on 15/08/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

protocol UserIdHandlerProtocol {
    static var userId: UserId {get}
}

class UserIdHandler: UserIdHandlerProtocol {
    class var userId: UserId {
        guard let cachedId = UserId.cachedUserId() else {
            let uuid  = self.generateUuid()
            let uId = UserId(id: uuid, visitType: "first_time", expiry: Date.init().addingMinutes(mins: 30))
            uId.cache()
            return uId
        }
        if cachedId.hasExpired() {
            cachedId.updateVisitType()
        }
        return cachedId
    }
    
    private class func generateUuid() -> String {
//        let timeInterval = NSDate().timeIntervalSince1970
//        let randomNumber = Int(arc4random_uniform(99)+1) * 100000
//        let uid = "uid-\(timeInterval)-\(randomNumber)"
        let uid = UUID().uuidString
        return uid
    }
}


