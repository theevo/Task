//
//  Task+Convenience.swift
//  Task
//
//  Created by theevo on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String? = nil, due: Date? = nil, moc: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
        self.notes = notes
        self.due = due
    }
    
    var dueDateAsString: String {
        get {
            guard let date = due else { return "no date set" }
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .medium
            return dateFormatter.string(from: date)
        }
    }
}
