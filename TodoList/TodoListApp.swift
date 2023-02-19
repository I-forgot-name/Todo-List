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
    private let mainCoordinator: MainCoordinator

    private let assembler = Assembler([TaskServiceAssembly()])
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)

        FirebaseApp.configure()
        mainCoordinator = .init(assembler) 
    }

    var body: some Scene {
        WindowGroup {
            mainCoordinator.start()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
