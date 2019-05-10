//
//  ScoreCell.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit

class ScoreCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tapsLbl: UILabel!
    
    func setUp(){
        self.layer.cornerRadius = self.frame.height*0.5
        self.backgroundColor = Color.primary.value
    }
}
