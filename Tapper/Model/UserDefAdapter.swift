//
//  UserDefAdapter.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 08/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import Foundation

protocol UserDefsAdapting {
    func getScore() -> [Score]
    func saveScore(score: Score) -> Bool
}

class UserDefsAdapter: UserDefsAdapting {
    
    let SCORES_KEY = "SCORES"

    func getScore() -> [Score] {
        var userData: [Score]! = []
        if let data = UserDefaults.standard.array(forKey: SCORES_KEY) as? [Data] {
            data.forEach{
                if let score = try? PropertyListDecoder().decode(Score.self, from: $0){
                    userData.append(score)
                }
                
            }
            return userData!
        } else {
            return userData
        }
    }
    
    func saveScore(score: Score) -> Bool {
        var currentScore = getScore().sorted(by: { $0.taps > $1.taps })
        
        if currentScore.count < 5 {
            currentScore.append(score)
            saveScores(scores: currentScore)
            return true
        } else if currentScore.last!.taps < score.taps {
            currentScore.removeLast(1)
            currentScore.append(score)
            saveScores(scores: currentScore)
            return true
        }
        
        return false
    }
    
    private func saveScores(scores: [Score]){
        var encodedData: [Data] = []
        scores.forEach{
            if let data = try? PropertyListEncoder().encode($0){
                encodedData.append(data)
            }
        }
        UserDefaults.standard.set(encodedData, forKey: SCORES_KEY)
    }
    
    
}
