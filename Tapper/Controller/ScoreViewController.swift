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
    private let sectionInsets = UIEdgeInsets(top: 16,
                                             left: 24,
                                             bottom: 16,
                                             right: 24)
    
    let places = [1, 2, 3, 4, 5]
    
    private var scores: [Score] = []
    private let userDefsAdapter: UserDefsAdapting
    
    init(userDefsAdapter: UserDefsAdapting = UserDefsAdapter()) {
        self.userDefsAdapter = userDefsAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.userDefsAdapter = UserDefsAdapter()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Color.secondary.value
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scores = userDefsAdapter.getScore()
        collectionView.reloadData()
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
        
        cell.setUp()
        cell.tapsLbl.text = "\(scores[indexPath.section].taps)"
        cell.timeLbl.text = scores[indexPath.section].time
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Place", for: indexPath) as? ScoreHeaderView
                else {
                    fatalError("Invalid view type")
            }
            let place = places[indexPath.section]
            headerView.label.text = "\(place)"
            headerView.setUp()
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}
// MARK: UICollectionViewDelegateFlowLayout
extension ScoreViewController: UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = view.frame.width
        
        
        return CGSize(width: availableWidth - sectionInsets.left*2, height: 80)
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
