//
//  MainCoordinator.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import Swinject

final class MainCoordinator {
    private let assembler: Assembler

    private lazy var addTaskCoordinator = AddTaskCoordinator(assembler)

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }

    func start() -> some View {
        let state = MainState()
        let store = MainStore(state: state)
        let contextProvider = assembler.resolver.resolve(IDBContextProvider.self)!
        let ac = MainActionCreator(
            store: store,
            service: assembler.resolver.resolve(ITasksService.self)!,
            repository: DBRepository(contextProvider: contextProvider, entityMapper: TaskEntityMapper())
        )
        let cv = MainContentView(ac: ac, addTaskCoordinator: addTaskCoordinator).environmentObject(store)
        return cv
    }
}
