//
//  CoreData+saveContext.swift
//  TodoList
//
//  Created by MacBook Pro on 27.04.2023.
//

import CoreData

extension NSManagedObjectContext {
    func saveContext() {
        guard hasChanges else { return }
        do {
            try save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
