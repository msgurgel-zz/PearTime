//
//  PomodoroQuestionViewController.swift
//  PearTime
//
//  Created by jamie tran on 2019-11-13.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class PomodoroQuestionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addQuestionTextField: UITextField!
    
    var questions: [String] = [NSLocalizedString("ReflectionQuestion_1", comment: "Test"),
                               NSLocalizedString("ReflectionQuestion_2", comment: ""),
                               NSLocalizedString("ReflectionQuestion_3", comment: "")]
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        insertNewQuestion()
    }
    
    // insert new row
    func insertNewQuestion(){
        questions.append(addQuestionTextField.text!)
        
        let indexPath = IndexPath(row: questions.count-1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addQuestionTextField.text = ""
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

}

extension PomodoroQuestionViewController: UITableViewDataSource, UITableViewDelegate{
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    // display all rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = questions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
        
        cell.setQuestion(question: question)
        return cell
    }
    
    // set ability to edit table view
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // delete a row from table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            questions.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
}
