//
//  Counter.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 08/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import Foundation

class TimeCounter {
    
    let TIMER_TICK = "TICK"
    let TIMER_END = "END"
    
    private var ticTimer: Timer?
    let timeInterval: Float = 0.01
    var timeLeft: Float = 0 {
        didSet{
            NotificationCenter.default.post(
                Notification(name: Notification.Name(rawValue: self.TIMER_TICK), object: self))
        }
    }
    
    init(countFrom value: Float) {
        timeLeft = value
    }
    
    func startTimer(){
        if ticTimer == nil {
            let timer = Timer.scheduledTimer(timeInterval: Double(timeInterval), target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            self.ticTimer = timer
        }
    }
    
    @objc func updateTimer(){
        timeLeft -= timeInterval
        // Time left may be not exactly zero because subtraction introduce some numeric error
        if timeLeft <= .zero {
            timeLeft = .zero
            endCounter()
        }
    }
    
    private func endCounter(){
        NotificationCenter.default.post(
            Notification(name: Notification.Name(rawValue: self.TIMER_END), object: self))
        ticTimer?.invalidate()
        ticTimer = nil
    }
}
