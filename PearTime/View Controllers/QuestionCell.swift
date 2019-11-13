//
//  QuestionCell.swift
//  PearTime
//
//  Created by jamie tran on 2019-11-13.
//  Copyright © 2019 Mateus Gurgel. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionView: UILabel!
    
    func setQuestion(question: String){
        questionView.text = question
    }
}
