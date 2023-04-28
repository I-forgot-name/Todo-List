//
//  IContextProviderAssembly.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import Swinject

public struct IContextProviderAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
         container.register(IContextProvider.self) { _ in
             ContextProvider()
         }
         .inObjectScope(.weak)
     }
 }
