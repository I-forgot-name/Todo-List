//
//  AddTaskCoordinator.swift
//  TodoList
//
//  Created by MacBook Pro on 28.02.2023.
//

import SwiftUI
import Swinject
import Storage

final class AddTaskCoordinator {

    private let assembler: Assembler

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }
    func start() -> some View {
        let state = AddTaskState()
        let store = AddTaskStore(state: state)
        let contextProvider = assembler.resolver.resolve(IContextProvider.self)!
        let ac = AddTaskActionCreator(
            store: store,
            storage: StorageCore(
                contextProvider: contextProvider,
                autoUpdateSearchRequest: TaskSearchRequest(),
                entityMapper: TaskEntityMapper()
            )
        )
        let view = AddTaskContentView(ac: ac).environmentObject(store)
        return view
    }
}
