//
//  TaskController.swift
//  Task
//
//  Created by theevo on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // MARK: - Properties
    
    // Singleton
    static var shared = TaskController()
    
    // Source of Truth
    var fetchedResultsController: NSFetchedResultsController<Task>
    

    init() {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let resultsController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was a really bad error, man.", error.localizedDescription)
        }
    }
    
    // MARK: - CRUD Functions
    
    func add(taskWithName name: String, notes: String?, due: Date?){
        
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // MARK: - Helper Functions
    
    var mockTasks: [Task] {
        let task1 = Task(name: "Do pre-work")
        let task2 = Task(name: "Finish iOS course", notes: "get badge by graduation day", due: Date())
        let task3 = Task(name: "Drive to Utah")
        task3.isComplete = true
        return [task1, task2, task3]
    }
    
    func fetchTasks() -> [Task] {
        return mockTasks
    }
} // end class TaskController
