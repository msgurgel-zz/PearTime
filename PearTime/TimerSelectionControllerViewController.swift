//
//  TimerSelectionControllerViewController.swift
//  PearTime
//
//  Created by Student on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class TimerSelectionControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shortBreakLabel.text=String(Int(shortBreakOutlet.value))
        longBreakLabel.text=String(Int(longBreakOutlet.value))
        workPeriodLabel.text=String(Int(workPeriodOutlet.value))
        
    }
    
    @IBOutlet weak var shortBreakLabel: UILabel!
    
    @IBOutlet weak var longBreakLabel: UILabel!
    
    @IBOutlet weak var workPeriodLabel: UILabel!
    
    @IBOutlet weak var shortBreakOutlet: UISlider!
    
    @IBOutlet weak var longBreakOutlet: UISlider!
    
    @IBOutlet weak var workPeriodOutlet: UISlider!
    
    
    @IBAction func shortBreakDuration(_ sender: UISlider) {
        shortBreakLabel.text=(String(Int(shortBreakOutlet
            .value)))
    }
    
    @IBAction func longBreakDuration(_ sender: UISlider) {
        longBreakLabel.text=(String(Int(longBreakOutlet
            .value)))
    }
    @IBAction func workPeriodDuration(_ sender: UISlider) {
        workPeriodLabel.text=(String(Int(workPeriodOutlet
            .value)))
    }
}
