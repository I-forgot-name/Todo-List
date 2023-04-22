//
//  AddTaskCoordinator.swift
//  TodoList
//
//  Created by MacBook Pro on 28.02.2023.
//

import SwiftUI
import Swinject

final class AddTaskCoordinator {

    private let assembler: Assembler

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }
    func start() -> some View {
        let state = AddTaskState()
        let store = AddTaskStore(state: state)
        let contextProvider = assembler.resolver.resolve(IDBContextProvider.self)!
        let ac = AddTaskActionCreator(
            store: store,
            service: assembler.resolver.resolve(ITasksService.self)!,
            repository: DBRepository(
                contextProvider: contextProvider,
                entityMapper: TaskEntityMapper()
            )
        )
        let view = AddTaskContentView(ac: ac).environmentObject(store)
        return view
    }
}
