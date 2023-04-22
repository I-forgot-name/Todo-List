//
//  IDBContextProviderAssembly.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import Swinject

struct IDBContextProviderAssembly: Assembly {
     func assemble(container: Container) {
         container.register(IDBContextProvider.self) { _ in
             DBContextProvider()
         }
         .inObjectScope(.weak)
     }
 }

