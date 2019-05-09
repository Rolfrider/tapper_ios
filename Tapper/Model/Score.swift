//
//  Score.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//
import UIKit

struct Score: Codable {
    
    
    let taps: Int
    let time: String
    
    init(taps: Int,time: String) {
        self.taps = taps
        self.time = time
    }
}
