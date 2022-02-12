//
//  Task+CoreDataProperties.swift
//  todo
//
//  Created by ismail palali on 12.02.2022.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskDescription: String
    @NSManaged public var recordDate: Date

}
