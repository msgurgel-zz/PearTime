// File        : TimerSelectionViewController.swift
// Project     : PearTime
// Author      : Adam Tunkiewicz
// Date        : October 4th, 2019
// Description : This file contains the controller connections for the
//               Pomorodo selection page. Once the values have been set, they
//               are sent to the timer page. 

import UIKit

class TimerSelectionControllerViewController: UIViewController {
    
    @IBOutlet weak var shortBreakLabel: UILabel!
    @IBOutlet weak var longBreakLabel: UILabel!
    @IBOutlet weak var workLabel: UILabel!
    
    @IBOutlet weak var shortBreakOutlet: UISlider!
    @IBOutlet weak var longBreakOutlet: UISlider!
    @IBOutlet weak var periodOutlet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial values are set when view is loaded
        shortBreakLabel.text=String(Int(shortBreakOutlet.value))
        longBreakLabel.text=String(Int(longBreakOutlet.value))
        workLabel.text=String(Int(periodOutlet.value))
    }
    
    // Updates the label once the short duration slider changes
    @IBAction func shortBreakDuration(_ sender: UISlider) {
        shortBreakLabel.text=(String(Int(shortBreakOutlet
            .value)))
    }
    
    // Updates the label once the long duration slider changes
    @IBAction func longBreakDuration(_ sender: UISlider) {
        longBreakLabel.text=(String(Int(longBreakOutlet
            .value)))
    }

    // Updates the work duration slider changes
    @IBAction func workDuration(_ sender: UISlider) {
        workLabel.text = (String(Int(periodOutlet.value)))
    }
    
    // This is used to send the data from this view to the timer view,
    // currently, the work and short break values are passed over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TimerViewController
        {
            let tvc = segue.destination as? TimerViewController
            tvc?.workDuration = Int(periodOutlet.value) * 60
            tvc?.shortBreakDuration = Int(shortBreakOutlet.value)*60
        }
    }
}
