//
//  IDBContextProvider.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData

protocol IDBContextProvider {

    /// Контекст с которым работает main поток
    /// - Returns: Контекст
    func mainQueueContext() -> NSManagedObjectContext

    /// https://developer.apple.com/documentation/coredata/nspersistentcontainer/1640581-newbackgroundcontext
    /// https://stackoverflow.com/questions/53633366/coredata-whats-the-difference-between-performbackgroundtask-and-newbackgroundc
    /// Контекст с которым работает фоновые потоки
    /// - Parameter block: Контекст
    func newBackgroundContext(_ block: @escaping (NSManagedObjectContext) -> Void)
}
