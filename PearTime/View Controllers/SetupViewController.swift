//
//  SetupViewController.swift
//  PearTime
//
//  Created by jamie tran on 2019-10-02.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let questions = ["What went good about the sessions?",
                     "What could be improved?",
                     "What are the next steps?"]
    
    @IBOutlet weak var softInterruptionsLabel: UILabel!
    @IBOutlet weak var hardInterruptionsLabel: UILabel!
    
    @IBOutlet weak var softInterruptionStepper: UIStepper!
    @IBOutlet weak var hardInterruptionStepper: UIStepper!
    
    @IBAction func softStepperValueChanged(_ sender: UIStepper) {
        self.softInterruptionsLabel.text = String(Int(sender.value))
    }
    @IBAction func hardStepperValueChanged(_ sender: UIStepper) {
        self.hardInterruptionsLabel.text = String(Int(sender.value))
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
