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
        guard let data = UserDefaults.standard.data(forKey: SCORES_KEY) else {
            return []
        }
        
        let decodedArray = try! JSONDecoder().decode([Score].self, from: data)
        
        return decodedArray.sorted(by: {$0.taps > $1.taps})
        
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
        let encodedData = try! JSONEncoder().encode(scores)
        UserDefaults.standard.set(encodedData, forKey: SCORES_KEY)
        
    }
    
    
}
