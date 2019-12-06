//
//  PomodoroQuestionViewController.swift
//  PearTime
//
//  Created by jamie tran on 2019-11-13.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit
import CoreData

class PomodoroQuestionViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addQuestionTextField: UITextField!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var questions: [String] = [NSLocalizedString("ReflectionQuestion_1", comment: ""),
                               NSLocalizedString("ReflectionQuestion_2", comment: ""),
                               NSLocalizedString("ReflectionQuestion_3", comment: "")]
    
    var questionss: [QuestionDB] = []
    
    var locations  = [QuestionDB]()

    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        insertNewQuestion(aQuestion: addQuestionTextField.text!)
    }
    
    // insert new row
    func insertNewQuestion(aQuestion: String){
        questions.append(aQuestion)
        
        let indexPath = IndexPath(row: questions.count-1, section: 0)
        let entity = NSEntityDescription.entity(forEntityName: "QuestionDB", in: context)
        let newQuestion = NSManagedObject(entity: entity!, insertInto: context)
        newQuestion.setValue(aQuestion, forKey: "desc")
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        addQuestionTextField.text = ""
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionDB")
        do {
            try
                locations = context.fetch(fetchRequest) as! [QuestionDB]
                print("Loading DB")
            
            for location in locations {
                questions.append(location.desc!)
                try context.save()
            }
        } catch {
            print("Could not fetch/save data")
        }

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
            let removedQuestion = questions.remove(at: indexPath.row)
            for location in locations{
                if location.desc == removedQuestion{
                    context.delete(location)
                    do {
                        try context.save()
                    } catch{
                        print("Could not save")
                    }
                    
                }
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
}
