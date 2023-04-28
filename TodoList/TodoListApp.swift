//
//  TodoListApp.swift
//  TodoList
//
//  Created by MacBook Pro on 15.01.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import struct Storage.IContextProviderAssembly
import Swinject

@main
struct TodoListApp: App {
    private let tabBarCoordinator: TabBarCoordinator

    private let assembler = Assembler(
        [
            TaskServiceAssembly(),
            IContextProviderAssembly()
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
        }
    }
}
