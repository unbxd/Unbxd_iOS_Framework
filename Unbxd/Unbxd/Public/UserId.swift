//
//  UserId.swift
//  Unbxd
//
//  Created by tilak kumar on 15/08/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

let kUserIdObjCacheKey = "kUserIdObjCacheKey"

public class UserId: NSObject, NSCoding {
    public let id: String
    public var visitType: String
    internal var expiry: Date
    
    init(id: String, visitType: String, expiry: Date) {
        self.id = id
        self.visitType = visitType
        self.expiry = expiry
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(visitType, forKey: "visitType")
        aCoder.encode(expiry, forKey: "expiry")
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.id = (aDecoder.decodeObject(forKey: "id") as? String)!
        self.visitType = (aDecoder.decodeObject(forKey: "visitType") as? String)!
        self.expiry = (aDecoder.decodeObject(forKey: "expiry") as? Date)!
    }
    
    func hasExpired() -> Bool {
        let currentDate = Date.init()
        return currentDate >= self.expiry
    }
    
    func updateVisitType() {
        self.visitType = "repeat"
        let futureDate = Date.init().addingYears(years: 10)
        self.expiry = futureDate
        self.cache()
    }
    
    func cache() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: kUserIdObjCacheKey)
        UserDefaults.standard.synchronize()
    }

    
    class func cachedUserId() -> UserId? {
        if let data = UserDefaults.standard.data(forKey: kUserIdObjCacheKey) {
            guard let userId = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserId else {
                return nil
            }
            return userId
        }
        return nil
    }
}
