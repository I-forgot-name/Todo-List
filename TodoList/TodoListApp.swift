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

    var body: some Scene {
        WindowGroup {
            TasksCV()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
