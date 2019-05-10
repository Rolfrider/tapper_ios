//
//  UserDefsScores.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 10/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import Foundation

class UserDefsScores{
    
    static private let SCORES_KEY = "SCORES"
    
    static private var scores: [Score]?
    
    static func getScores() -> [Score] {
        return (scores ?? readScore()).sorted(by: {$0.taps > $1.taps})
    }
    
    private static func readScore() -> [Score] {
        guard let data = UserDefaults.standard.data(forKey: SCORES_KEY) else {
            return []
        }
        
        let decodedArray = try! JSONDecoder().decode([Score].self, from: data)
        
        return decodedArray
    }
    
    static func saveScore(score: Score) -> Bool {
        var currentScore = getScores()
        
        if currentScore.count < 5 {
            currentScore.append(score)
            scores = currentScore
            saveScores()
            return true
        } else if currentScore.last!.taps < score.taps {
            currentScore.removeLast(1)
            currentScore.append(score)
            scores = currentScore
            saveScores()
            return true
        }
        
        return false
    }
    
    private static func saveScores(){
        let encodedData = try! JSONEncoder().encode(getScores())
        UserDefaults.standard.set(encodedData, forKey: SCORES_KEY)
        
    }
    
    
}
