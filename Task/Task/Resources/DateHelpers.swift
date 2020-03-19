//
//  DateHelpers.swift
//  Task
//
//  Created by theevo on 3/5/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation

extension Date {    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
