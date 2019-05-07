//
//  ScoreProvider.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import Foundation

protocol ScoreProviding {
    func provideScores(key: String) -> [Score]
}

class UserDefsScoreProvider: ScoreProviding {
    
    func provideScores(key: String) -> [Score] {
        return UserDefaults.standard.array(forKey: key) as? [Score] ?? [Score]()
    }

}
