//
//  Task+CoreDataProperties.swift
//  Prioritask
//
//  Created by Vincentius Ian Widi Nugroho on 27/04/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var importance: String?
    @NSManaged public var name: String?
    @NSManaged public var time: String?
    @NSManaged public var urgency: Int16

}

extension Task : Identifiable {

}
