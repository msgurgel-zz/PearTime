// File        : TimerViewController.swift
// Project     : PearTime
// Author      : Mateus Gurgel
// Date        : October 4th, 2019
// Description : Handles the logic of the Timer page

import UIKit

class TimerViewController: UIViewController {
   
    // Values passed from the previous screen
    var workDuration : Int?
    var shortBreakDuration : Int?
    var longBreakDuration : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentTime = workDuration!
        updateTimer(timeInSec: currentTime)
        
        breakLabel.text = ""
    }

    var currentTime = 0
    var isRunning = false
    var isBreak = false
    var timer : Timer?
    
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var breakLabel: UILabel!
    @IBOutlet weak var startOutlet: UIButton!

    @IBAction func start(_ sender: Any) {
        toggleTimer()
    }
    
    @IBAction func stop(_ sender: Any) {
        isBreak = false
        stopTimer(workDuration!)
        
        matchProgressColourToTimer()
        updateBreakLabel()
        startOutlet.setTitle("Start", for: .normal)
    }
    
    @IBAction func doubleTapTimer(_ gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .ended {
            toggleTimer()
        }
    }
    
    func toggleTimer() -> Void {
        if isRunning {
            pauseTimer()
            startOutlet.setTitle("Start", for: .normal)
        }
        else {
            startTimer()
            startOutlet.setTitle("Pause", for: .normal)
        }
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
    
    func stopTimer(_ newTime : Int = 0) -> Void {
        pauseTimer()
        
        currentTime = newTime

        updateTimer(timeInSec: currentTime)
    }
    
    @objc func decreaseCounter() -> Void {
        self.currentTime -= 1
        
        if self.currentTime <= 0 {
            stopTimer()
            if isBreak {
                currentTime = workDuration!
                updateTimer(timeInSec: currentTime)
                startOutlet.setTitle("Start", for: .normal)
                
                isBreak = false
            } else {
                currentTime = shortBreakDuration!
                updateTimer(timeInSec: currentTime)
                startTimer()
                
                isBreak = true
            }
            matchProgressColourToTimer()
            updateBreakLabel()
        }
        
        updateTimer(timeInSec: currentTime)
    }
    
    func matchProgressColourToTimer()
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
   
    // Hides or shows the Break label depending on if it's
    // break time or not.
    func updateBreakLabel()
    {
        if isBreak
        {
            breakLabel.text = "Break Time!"
        }
        else
        {
            breakLabel.text = ""
        }
    }
    
    func updateTimer(timeInSec t : Int) -> Void {
        let minutes = t / 60
        let seconds = t % 60
        
        var totalTime = 0
        if isBreak {
            totalTime = shortBreakDuration!
        } else {
            totalTime = workDuration!
        }
        
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        circularProgress.angle = Double((360 * t) / totalTime)
    }
}
