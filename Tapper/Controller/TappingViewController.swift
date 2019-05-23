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
        tapsCounterLbl.alpha = 0
        timeLbl.alpha = 0
        self.registerObservers()
        view.isUserInteractionEnabled = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    func displayTime() {
        let leftTime: Int = Int(timeCounter.timeLeft*100)
        timeLbl.text = String(format: "%02d:%02d", leftTime/100, leftTime % 100)
    }
    
    func displayTaps() {
        tapsCounterLbl.text = "\(tapCounter.taps)"
    }
    
    @objc func endGame() {
        
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
        
        let size = CGSize(width: 500, height: 500)
        let frame = CGRect(origin: .zero, size: size)
        let endFontSize: CGFloat = 200.0
        let duration: Double = 0.5
        let font = UIFont(name: "GillSans-SemiBoldItalic", size: 20.0)
        
        let labels = [UILabel(frame: frame),UILabel(frame: frame),UILabel(frame: frame),UILabel(frame: frame)]
        
        let scale = labels[0].font.pointSize / endFontSize
        
        labels.forEach{
            $0.center = self.view.center
            $0.alpha = 0
            $0.textAlignment = .center
            $0.transform = $0.transform.scaledBy(x: scale, y: scale)
            $0.textColor = Color.primary.value
            $0.font = font
            self.view.addSubview($0)
        }
        
        labels[0].text = "1"
        labels[1].text = "2"
        labels[2].text = "3"
        labels[3].text = "Play"
        
        UIView.animate(withDuration: duration, animations: {
            labels[0].transform = .identity
            labels[0].alpha = 1
            labels[0].font = labels[0].font.withSize(endFontSize)
        }){
            completed in
            labels[0].removeFromSuperview()
            UIView.animate(withDuration: duration, animations: {
                labels[1].transform = .identity
                labels[1].alpha = 1
                labels[1].font = labels[1].font.withSize(endFontSize)
            }){
                completed in
                labels[1].removeFromSuperview()
                UIView.animate(withDuration: duration, animations: {
                    labels[2].transform = .identity
                    labels[2].alpha = 1
                    labels[2].font = labels[2].font.withSize(endFontSize)
                }){
                    completed in
                    labels[2].removeFromSuperview()
                    UIView.animate(withDuration: duration*3, animations: {
                        labels[3].transform = .identity
                        labels[3].alpha = 1
                        labels[3].font = labels[3].font.withSize(endFontSize)
                    }){
                        completed in
                        labels[3].removeFromSuperview()
                        self.tapsCounterLbl.alpha = 1
                        self.timeLbl.alpha = 1
                        self.timeCounter.startTimer()
                        self.view.isUserInteractionEnabled = true
                    }
                }
            }
        }
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
        forName: NSNotification.Name(timeCounter.TIMER_TICK), object: timeCounter, queue: OperationQueue.main){
            [weak self] _ in
            self?.displayTime()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(timeCounter.TIMER_END), object: timeCounter, queue: nil){
            [weak self] _ in
            self?.endGame()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(tapCounter.TAP_COUNT), object: tapCounter, queue: OperationQueue.main){
            [weak self] _ in
            self?.displayTaps()
        }
        
        NotificationCenter.default.addObserver(
        forName: NSNotification.Name(tapCounter.TAP_RECORD), object: tapCounter, queue: OperationQueue.main){
            [weak self] _ in
            self?.displayNotification()
        }
    }
}
