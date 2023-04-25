//
//  MainActionCreatorBuilder.swift
//  TodoList
//
//  Created by MacBook Pro on 23.04.2023.
//

struct MainActionCreatorBuilder {

//    MARK: Properties

    private let assembler: Assembler
    private let repository: DBRepository<TaskDomainModel, TaskEntity>

    private let contextProvider: IDBContextProvider
    private let service: ITasksService

    private let mapper = TaskEntityMapper()

//    MARK: Init

    init(_ assembler: Assembler) {
        self.assembler = assembler
        contextProvider = assembler.resolver.resolve(IDBContextProvider.self)!
        repository = DBRepositoryBuilder.make(
            contextProvider: contextProvider,
            mapper: mapper
        )
        service = assembler.resolver.resolve(ITasksService.self)!
    }

//    MARK: Functions

    func build(store: MainStore) -> MainActionCreator {
        MainActionCreator(
            store: store,
            service: service,
            repository: repository
        )
    }
}
