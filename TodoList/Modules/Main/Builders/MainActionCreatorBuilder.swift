//
//  MainActionCreatorBuilder.swift
//  TodoList
//
//  Created by MacBook Pro on 23.04.2023.
//

import Swinject
import Storage

struct MainActionCreatorBuilder {

//    MARK: Properties

    private let assembler: Assembler
    private let storage: StorageCore<TaskDomainModel, TaskEntity>

    private let contextProvider: IContextProvider
    private let service: ITasksService

    private let mapper = TaskEntityMapper()

//    MARK: Init

    init(_ assembler: Assembler) {
        self.assembler = assembler
        contextProvider = assembler.resolver.resolve(IContextProvider.self)!
        storage = StorageCoreBuilder.make(
            contextProvider: contextProvider,
            request: TaskSearchRequest(),
            mapper: mapper
        )
        service = assembler.resolver.resolve(ITasksService.self)!
    }

//    MARK: Functions

    func build(store: MainStore) -> MainActionCreator {
        MainActionCreator(
            store: store,
            storage: storage
        )
    }
}
