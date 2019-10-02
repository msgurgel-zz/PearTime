//
//  TimerViewController.swift
//  PearTime
//
//  Created by Mateus Gurgel on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var currentTime = 25 * 60
    var isRunning = false
    var timer : Timer?
    
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startOutlet: UIButton!
    

    @IBAction func start(_ sender: Any) {
        // Toggle button Text between "Start" and "Pause"
        if isRunning {
            startOutlet.setTitle("Start", for: .normal)
            pauseTimer()
        }
        else {
            startOutlet.setTitle("Pause", for: .normal)
            startTimer()
        }
        
      
    }
    
    @IBAction func stop(_ sender: Any) {
    }
    
    let context = ["user": "@twostraws"]

    func startTimer() -> Void {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decreaseCounter), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() -> Void {
       timer!.invalidate()
    }
    
    func stopTimer() -> Void {
        
    }
    
    @objc func decreaseCounter() -> Void {
        self.currentTime -= 1
        
        updateTimerLabel(timeInSec: currentTime)
        
        if self.currentTime == 0 {
            stopTimer()
        }
    }
    
    func updateTimerLabel(timeInSec t : Int) -> Void {
        let minutes = t / 60
        let seconds = t % 60
        timerLabel.text = String(format: "%.0f", minutes) + ":" + String(seconds)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
