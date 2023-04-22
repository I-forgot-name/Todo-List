//
//  TodoListApp.swift
//  TodoList
//
//  Created by MacBook Pro on 15.01.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import Swinject

@main
struct TodoListApp: App {
    let persistenceController = PersistenceController.shared
    private let tabBarCoordinator: TabBarCoordinator

    private let assembler = Assembler(
        [
            TaskServiceAssembly(),
            IDBContextProviderAssembly()
        ]
    )
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)

        FirebaseApp.configure()
        tabBarCoordinator = .init(assembler) 
    }

    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.start()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
