//
//  VisitorEventHandler.swift
//  Unbxd
//
//  Created by tilak kumar on 07/09/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

let kLastVisitTimeKey = "kLastVisitTimeKey"
let kTimeOutInterval = 60 * 30 //30 mins

class VisitorEventHandler {
    
    var httpResponse: HTTPURLResponse?
    var lastEventFiredTime: Date?
    var sendingEvent = false
    
    func isRecentEventFiredWithinTimeout() -> Bool {
        let currentTime = Date()
        
        if lastEventFiredTime != nil {
            let diff = Int(currentTime.timeIntervalSince1970 - lastEventFiredTime!.timeIntervalSince1970)
            return diff < kTimeOutInterval
        }
        
        return false
    }
    
    func isLastEventFiredPastTimeout() -> Bool {
        let currentTime = Date()
        
        if let lastVisitTime = self.getLastVisitTime() {
            let diff = Int(currentTime.timeIntervalSince1970 - lastVisitTime.timeIntervalSince1970)
            return diff > kTimeOutInterval
        }
        
        return true
    }
    
    func checkIfVisitorEventToBeSent() {
        if sendingEvent == true {
            //DDLogDebug("1. Visitor event being sent.....")
            return
        }
        
        if self.isRecentEventFiredWithinTimeout() {
            //DDLogDebug("2. Visitor event fired just with timeout.....")
            return
        }
        
        if self.isLastEventFiredPastTimeout() {
            self.sendVisitorEvent()
        }
        else {
            //DDLogDebug("3. Last visitor event fired timeout not passes.....")
        }
    }
    
    func sendVisitorEvent() {
        sendingEvent = true

        let userId = UserIdHandler.userId
        
        let reqId = self.httpResponse?.unbxdRequestId() ?? ""
        
        let visitorAnalytics = VisitorAnalytics(uid: userId.id, visitType: userId.visitType, requestId: reqId)
        
        RequestHandler.sharedHandler.track(query: visitorAnalytics) { [weak self] (responseJSON, httpResponse, err) in
            
            self?.sendingEvent = false
            if err == nil {
                Logger.logDebug("Visitor event sent!")
                
                let currentTime = Date()
                self?.lastEventFiredTime = currentTime
                self?.setLastVisitTime(date: currentTime)
            }
            else {
                Logger.logError("Failed sending visitor event")
            }
        }
    }
    
    func getLastVisitTime() -> Date? {
        return UserDefaults.standard.object(forKey: kLastVisitTimeKey) as? Date
    }
    
    func setLastVisitTime(date: Date) {
        UserDefaults.standard.set(date, forKey: kLastVisitTimeKey)
        UserDefaults.standard.synchronize()
    }
}

extension HTTPURLResponse {
    func unbxdRequestId() -> String? {
        if let allHeaders = self.allHeaderFields as? [String: String] {
            if let id = allHeaders["Unbxd-Request-Id"] {
                return id
            }
            else if let xid = allHeaders["x-request-id"] {
                return xid
            }
        }
        return nil
    }
}
