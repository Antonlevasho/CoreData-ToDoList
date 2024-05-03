//
//  Function.swift
//  ToDoListDemoSecond
//
//  Created by Анастасия on 02.05.2024.
//

import Foundation
import UIKit

//MARK: - Function

extension ViewController {

func getAllItems() {
    do {
        models = try context.fetch(ToDoListDemo.fetchRequest())
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    } catch {
        
    }
}

func createItem(name: String) {
    let newItem = ToDoListDemo(context: context)
    newItem.name = name
    newItem.creatingAt = Date()
    
    do {
        try context.save()
        getAllItems()
    } catch {
        
    }
}

func deleteItem(item: ToDoListDemo) {
    context.delete(item)
    
    do {
        try context.save()
        getAllItems()
    } catch {
        
    }
}

func updateItem(item: ToDoListDemo, newName: String) {
    item.name = newName
    
    do {
        try context.save()
        getAllItems()
    } catch {
        
    }
}
    
}
