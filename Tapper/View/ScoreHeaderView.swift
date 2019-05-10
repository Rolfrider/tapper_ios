//
//  ScoreHeaderView.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 09/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit

class ScoreHeaderView: UICollectionReusableView {
    @IBOutlet weak var label: UILabel!
    
    func setUp(){
        label.textColor = Color.darkPrimary.value
    }
}
