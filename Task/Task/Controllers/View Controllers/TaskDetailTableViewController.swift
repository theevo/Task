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
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        //Creating out tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userTappedView))
        
        //adding our tap gesture to our view
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: - Action functions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newTaskName = taskNameTextField.text ?? ""
        
        // if there's something on the landing pad, update
        if let task = taskLandingPad {
            TaskController.shared.update(task: task, name: newTaskName, notes: taskNotesTextView.text, due: dueDateValue)
        } else { // else, add new Task
            TaskController.shared.add(taskWithName: newTaskName, notes: taskNotesTextView.text, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        dueDateTextField.text = dueDateValue?.stringValue()
    }
    
    @objc func userTappedView() {
        taskNameTextField.resignFirstResponder()
        taskNotesTextView.resignFirstResponder()
        dueDateTextField.resignFirstResponder()
    }
    
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let taskToDisplay = taskLandingPad,
            let taskName = taskToDisplay.name
            else { return }
        
        taskNameTextField.text = taskToDisplay.name
        taskNotesTextView.text = taskToDisplay.notes
        dueDateTextField.text = taskToDisplay.due?.stringValue()
        dueDateTextField.inputView = dueDatePicker
    }
    
} // end class
