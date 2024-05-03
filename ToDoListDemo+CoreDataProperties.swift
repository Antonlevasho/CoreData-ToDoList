//
//  ToDoListDemo+CoreDataProperties.swift
//  ToDoListDemoSecond
//
//  Created by Анастасия on 02.05.2024.
//
//

import Foundation
import CoreData


extension ToDoListDemo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListDemo> {
        return NSFetchRequest<ToDoListDemo>(entityName: "ToDoListDemo")
    }

    @NSManaged public var name: String?
    @NSManaged public var creatingAt: Date?

}

extension ToDoListDemo : Identifiable {

}
