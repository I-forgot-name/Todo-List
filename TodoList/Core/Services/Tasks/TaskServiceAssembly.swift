//
//  TaskServiceAssembly.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

import Swinject

struct TaskServiceAssembly: Assembly {
     func assemble(container: Container) {
         container.register(ITasksService.self) { _ in
             TasksService()
         }
         .inObjectScope(.weak)
     }
 }
