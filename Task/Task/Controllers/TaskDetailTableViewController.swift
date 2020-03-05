//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by theevo on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // Landing Pad
    var taskLandingPad: Task?
    var dueDateValue: Date?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextLabel: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var dueDateTextLabel: UITextField!
    
    
    
    // MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Action functions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newTaskName = taskNameTextLabel.text ?? ""
        
        // if there's something on the landing pad, update
        if let task = taskLandingPad {
            TaskController.sharedInstance.update(task: task, name: newTaskName, notes: taskNotesTextView.text, due: Date())
        } else { // else, add new Task
            TaskController.sharedInstance.add(taskWithName: newTaskName, notes: taskNotesTextView.text, due: Date())
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let taskToDisplay = taskLandingPad else {return}
        taskNameTextLabel.text = taskToDisplay.name
        taskNotesTextView.text = taskToDisplay.notes
        dueDateTextLabel.text = taskToDisplay.due?.stringValue()
    }
    
} // end class
