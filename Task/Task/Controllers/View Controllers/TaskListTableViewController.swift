//
//  TaskListTableViewController.swift
//  Task
//
//  Created by theevo on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return TaskController.shared.tasks.count
        return TaskController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        
//        let task = TaskController.shared.tasks[indexPath.row]
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.setTask(task: task)
        cell.delegate = self


        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
//            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            let taskToDelete = TaskController.shared.fetchedResultsController.object(at: indexPath)
            
            TaskController.shared.remove(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        
        if segue.identifier == "toTaskDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? TaskDetailTableViewController
                else { return }
                
//            let taskToSend = TaskController.shared.tasks[indexPath.row]
            let taskToSend = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.taskLandingPad = taskToSend
        }
    }
    

} // end class



// MARK: - Cell Delegate

extension TaskListTableViewController: ButtonTableViewCellDelegate {
    
}


// MARK: - NSFetchedResultsControllerDelegate

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
   func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.beginUpdates()
   }
   func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       tableView.endUpdates()
   }
   //sets behavior for cells
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
       switch type{
           case .delete:
               guard let indexPath = indexPath else { break }
               tableView.deleteRows(at: [indexPath], with: .fade)
           case .insert:
               guard let newIndexPath = newIndexPath else { break }
               tableView.insertRows(at: [newIndexPath], with: .automatic)
           case .move:
               guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
               tableView.moveRow(at: indexPath, to: newIndexPath)
           case .update:
               guard let indexPath = indexPath else { break }
               tableView.reloadRows(at: [indexPath], with: .automatic)
           @unknown default:
               fatalError()
       }
   }
   //additional behavior for cells
   func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
       switch type {
           case .insert:
               tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
           case .delete:
               tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
           case .move:
               break
           case .update:
               break
           @unknown default:
               fatalError()
       }
   }
} // end extension NSFetchedResultsControllerDelegate
