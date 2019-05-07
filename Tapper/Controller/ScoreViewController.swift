//
//  ScoreViewController.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit

class ScoreViewController: UICollectionViewController {
    
    private let reuseIdentifier = "Score"
    private let sectionInsets = UIEdgeInsets(top: 20,
                                             left: 20,
                                             bottom: 20,
                                             right: 20)
    
    private var scores: [Score] = []
    private let scoreProvider: ScoreProviding
    
    init(scoreProvider: ScoreProviding = UserDefsScoreProvider()) {
        self.scoreProvider = scoreProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scoreProvider = UserDefsScoreProvider()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores = scoreProvider.provideScores(key: ViewController.SCORES_KEY)
    }
    
    
    
    
    
}
// MARK: private methods


// MARK: UICollectionViewDataSource
extension ScoreViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return scores.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScoreCell
        
        cell.backgroundColor = .green
        //cell.tapsLbl.text = "\(scores[indexPath.row].taps)"
        //cell.timeLbl.text = scores[indexPath.row].time
        
        return cell
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension ScoreViewController: UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = view.frame.width
        
        
        return CGSize(width: availableWidth, height: 98)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
