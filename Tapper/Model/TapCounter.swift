//
//  TapCounter.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 08/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import Foundation

class TapCounter {
    
    let TAP_COUNT = "TAP"
    let TAP_RECORD = "RECORD"
    
    var newRecord = false
    
    let gameDate: String

    var taps: Int = 0 {
        didSet{
            NotificationCenter.default.post(
                Notification(name: Notification.Name(rawValue: self.TAP_COUNT), object: self))
        }
    }
    
    init() {
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        gameDate = formatter.string(from: now)
    }
    
    func storeScore() {
        let score = Score(taps: self.taps, time: self.gameDate)
        newRecord = UserDefsScores.saveScore(score: score)
        NotificationCenter.default.post(
            Notification(name: Notification.Name(rawValue: self.TAP_RECORD), object: self))
        
    }
}
