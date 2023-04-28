//
//  ContextProvider.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData

public final class ContextProvider {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoList")

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error),\(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        return container
    }()

    private lazy var mainContext = persistentContainer.viewContext
}

// MARK: - IDBContextProvider

extension ContextProvider: IContextProvider {
    public func mainQueueContext() -> NSManagedObjectContext {
        mainContext
    }

    public func newBackgroundContext(_ block: @escaping (NSManagedObjectContext) -> Void) {
        block(persistentContainer.newBackgroundContext())
    }
}
