//
//  TappingViewController.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit

class TappingViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var tapsLbl: UILabel!
    
    let timeCounter: TimeCounter = TimeCounter(countFrom: 5.0)
    let tapCounter = TapCounter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.secondary.value
        
        self.registerObservers()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timeCounter.startTimer()
    }
    
    func displayTime() {
        timeLbl.text = "\(timeCounter.timeLeft)"
    }
    
    func displayTaps() {
        tapsLbl.text = "\(tapCounter.taps)"
    }
    
    func endGame() {
        tapCounter.storeScore()
    }
    
    func displayNotification(){
        
        let alertmessage: String
        if tapCounter.newRecord {
            alertmessage = "You are qualified for the list of records. You taped \(tapCounter.taps) times"
        } else {
            alertmessage = "You taped \(tapCounter.taps) times"
        }
        
        let alertController = UIAlertController(title: "Congratulations!", message:
            alertmessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Thanks", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        tapCounter.taps += 1
    }
    
}
// MARK: - Private
extension TappingViewController{
    
    private func registerObservers(){
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(timeCounter.TIMER_TICK), object: nil, queue: nil){
            (Notification) -> Void in
            self.displayTime()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(timeCounter.TIMER_END), object: nil, queue: nil){
            (Notification) -> Void in
            self.endGame()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(tapCounter.TAP_COUNT), object: nil, queue: nil){
            (Notification) -> Void in
            self.displayTaps()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(tapCounter.TAP_RECORD), object: nil, queue: nil){
            (Notification) -> Void in
            self.displayNotification()
        }
    }
}
