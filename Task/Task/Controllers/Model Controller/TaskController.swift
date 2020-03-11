//
//  TaskController.swift
//  Task
//
//  Created by theevo on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation

class TaskController {
    
    // MARK: - Properties
    
    // singleton
    static var sharedInstance = TaskController()
    
    // source of truth
    var tasks: [Task] = []
    
    var mockTasks: [Task] {
        let task1 = Task(name: "Do pre-work")
        let task2 = Task(name: "Finish iOS course", notes: "get badge by graduation day", due: Date())
        let task3 = Task(name: "Drive to Utah")
        task3.isComplete = true
        return [task1, task2, task3]
    }
    
    init() {
        tasks = fetchTasks()
    }
    
    // MARK: - CRUD Functions
    
    func add(taskWithName name: String, notes: String?, due: Date?){
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    func remove(task: Task) {
        
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        
    }
    
    func fetchTasks() -> [Task] {
        return mockTasks
    }
}
