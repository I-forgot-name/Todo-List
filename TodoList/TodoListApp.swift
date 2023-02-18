//
//  TodoListApp.swift
//  TodoList
//
//  Created by MacBook Pro on 15.01.2023.
//

import SwiftUI

@main
struct TodoListApp: App {
    let persistenceController = PersistenceController.shared
    let mainCoordinator = MainCoordinator()

    var body: some Scene {
        WindowGroup {
            mainCoordinator.start()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
