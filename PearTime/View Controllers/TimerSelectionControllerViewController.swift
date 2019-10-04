//
//  TimerSelectionControllerViewController.swift
//  PearTime
//
//  Created by Student on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

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

        // Do any additional setup after loading the view.
        shortBreakLabel.text=String(Int(shortBreakOutlet.value))
        longBreakLabel.text=String(Int(longBreakOutlet.value))
        
            workLabel.text=String(Int(periodOutlet.value))
    }
    
    @IBAction func shortBreakDuration(_ sender: UISlider) {
        shortBreakLabel.text=(String(Int(shortBreakOutlet
            .value)))
    }
    
    @IBAction func longBreakDuration(_ sender: UISlider) {
        longBreakLabel.text=(String(Int(longBreakOutlet
            .value)))
    }

    @IBAction func workDuration(_ sender: UISlider) {
        workLabel.text = (String(Int(periodOutlet.value)))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TimerViewController
        {
            let tvc = segue.destination as? TimerViewController
            tvc?.workDuration = Int(periodOutlet.value) * 60
        }
    }
}
