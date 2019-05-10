//
//  ViewController.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 06/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
        

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.secondary.value
        setUpTitleLbl()
        setUpPlayButton()
        
    }
    



}

// Mark: - Private
extension ViewController {
    
    private func setUpPlayButton(){
        playButton.layer.cornerRadius = 16
        playButton.setTitleColor(Color.darkPrimary.value, for: .normal)
        playButton.backgroundColor = Color.accent.value
    }
    
    private func setUpTitleLbl(){
        titleLbl.textColor = Color.primary.value
    }
}

