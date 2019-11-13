// File        : SetupViewController.Swift
// Project     : PearTime
// Author      : Jamie Tran
// Date        : October 4th, 2019
// Description : Handles the logic of the Setup Page

import UIKit

/* Function: SetupViewController
 * Description: Viewcontroller for setup screen that will control how inturreptions
 * and questions are laid out during the application
 */
class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // declare tap gesture for dismissing keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /* Function: dismissKeyboard
     * Input: void
     * Output: void
     * Description: dismiss keyboard
     */
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBOutlet weak var softInterruptionsLabel: UILabel!
    @IBOutlet weak var hardInterruptionsLabel: UILabel!
    
    @IBOutlet weak var softInterruptionStepper: UIStepper!
    @IBOutlet weak var hardInterruptionStepper: UIStepper!
    
    /* Function: softStepperValueChanged
     * Input: _ sender: UIStepper
     * Output: void
     * Description: On stepper change, update text of soft interruption
     */
    @IBAction func softStepperValueChanged(_ sender: UIStepper) {
        self.softInterruptionsLabel.text = String(Int(sender.value))
    }
    
    /* Function: hardStepperValueChanged
     * Input: _ sender: UIStepper
     * Output: void
     * Description: On stepper change, update text of hard interruption
     */
    @IBAction func hardStepperValueChanged(_ sender: UIStepper) {
        self.hardInterruptionsLabel.text = String(Int(sender.value))
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}
