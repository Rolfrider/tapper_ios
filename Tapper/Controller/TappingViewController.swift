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
    @IBOutlet weak var tapLbl: UILabel!
    @IBOutlet weak var meLbl: UILabel!
    @IBOutlet weak var tapsCounterLbl: UILabel!
    
    let timeCounter: TimeCounter = TimeCounter(countFrom: 5.0)
    let tapCounter = TapCounter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.secondary.value
        timeLbl.textColor = Color.primary.value
        tapLbl.textColor = Color.darkPrimary.value
        meLbl.textColor = Color.darkPrimary.value
        tapsCounterLbl.textColor = Color.primary.value
        self.registerObservers()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timeCounter.startTimer()
        startAnimation()
    }
    
    func displayTime() {
        let leftTime: Int = Int(timeCounter.timeLeft*100)
        timeLbl.text = String(format: "%02d:%02d", leftTime/100, leftTime % 100)
    }
    
    func displayTaps() {
        tapsCounterLbl.text = "\(tapCounter.taps)"
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
        alertController.addAction(UIAlertAction(title: "Thanks", style: .default, handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        tapCounter.taps += 1
        animateTap(forLocation: sender.location(in: self.view))
        
    }
    
}
// MARK: - Private
extension TappingViewController{
    
    private func startAnimation(){
        
        let size = CGSize(width: 200, height: 250)
        let label = UILabel(frame: CGRect(origin: .zero, size: size))
        label.center = view.center
        
    }
    
    private func animateTap(forLocation location: CGPoint){
        let touchView = UIView()
        let size = CGSize(width: 100, height: 100)
        touchView.frame = CGRect(origin: .zero, size: size)
        touchView.center = location
        touchView.backgroundColor = Color.darkPrimary.value
        touchView.layer.cornerRadius = size.width*0.5
        view.addSubview(touchView)
        touchView.alpha = 0.5
        let animator = UIViewPropertyAnimator(duration: 0.3,curve: .easeInOut){
            touchView.transform = .init(scaleX: 0.1, y: 0.1)
            touchView.alpha = 0
        }
        
        animator.addCompletion{ (pos) in
            if pos == .end{
                touchView.removeFromSuperview()
            }
            
        }
        
        animator.startAnimation()
        
    }
    
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
