//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by theevo on 3/5/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate: class {
    
}

class ButtonTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    
    // MARK: - Properties
    
    var task: Task?
    weak var delegate: ButtonTableViewCellDelegate?
    
    
    // MARK: - Actions
    @IBAction func checkboxTapped(_ sender: Any) {
        if let task = task {
            task.toggleIsChecked()
            updateCheckbox()
        }
        
    }
    
    
    // MARK: - Helper Functions
    
    func setTask(task: Task){
        self.task = task
        updateUI()
    }
    
    func updateUI() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        dueDateLabel.text = task.dueDateAsString
        
        updateCheckbox()
    }
    
    func updateCheckbox() {
        guard let task = task else { return }
        
        if task.isComplete {
            checkboxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            checkboxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
}
