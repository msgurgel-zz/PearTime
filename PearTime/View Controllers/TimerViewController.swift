//
//  TimerViewController.swift
//  PearTime
//
//  Created by Mateus Gurgel on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    var workDuration : Int?
    var shortBreakDuration : Int?
    var longBreakDuration : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        breakLabel.text=""
        currentTime = workDuration!
        updateTimer(timeInSec: currentTime)
        changeColour()
    }
    
    //    let timerInitVal = 30 // 25 * 60 // This will be substituted by the value given from the Timer Select Screen
    
    var currentTime = 0
    var isRunning = false
    var isBreak = false
    var timer : Timer?
    
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    @IBOutlet weak var startOutlet: UIButton!
    
    @IBAction func start(_ sender: Any) {
        if isRunning {
            pauseTimer()
            startOutlet.setTitle("Start", for: .normal)
        }
        else {
            startTimer()
            startOutlet.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        stopTimer()
        currentTime = workDuration!
        isBreak = false
        
        startOutlet.setTitle("Start", for: .normal)
    }
    
    func startTimer() -> Void {
        isRunning = true
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(decreaseCounter),
            userInfo: nil,
            repeats: true
        )
    }
    
    func startBreak() -> Void {
        isRunning = true
    }
    
    func pauseTimer() -> Void {
        isRunning = false
        if let t = timer {
            t.invalidate()
        }
    }
    
    func stopTimer() -> Void {
        pauseTimer()
        
        currentTime = 0
        updateTimer(timeInSec: currentTime)
        updateBreakLabel()
    }
    
    @objc func decreaseCounter() -> Void {
        self.currentTime -= 1
        
        updateTimer(timeInSec: currentTime)
        
        if self.currentTime <= 0 {
            stopTimer()
            if isBreak {
                isBreak = false
                stopTimer()
                currentTime = workDuration!
                updateTimer(timeInSec: currentTime)
            } else {
                isBreak = true
                currentTime = shortBreakDuration!
                updateTimer(timeInSec: currentTime)
                startTimer()
            }
            changeColour()
            updateBreakLabel()
        }
    }
    
    func changeColour()
    {
        if isBreak
        {
            circularProgress.set(colors: UIColor.green)
        }
        else
        {
            circularProgress.set(colors: UIColor.cyan)
        }
    }
    
    func updateBreakLabel()
    {
        if isBreak
        {
            breakLabel.text = "Break Time!"
        }
        else
        {
            breakLabel.text=""
        }
    }
    
    func updateTimer(timeInSec t : Int) -> Void {
        let minutes = t / 60
        let seconds = t % 60
        
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        circularProgress.angle = Double((360 * t) / workDuration!)
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
