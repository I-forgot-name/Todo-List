//
//  AddTaskStore.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

import Foundation

enum AddTaskAction {
    case didChangeTitle(String)
}

final class AddTaskStore: ObservableObject {
    private var reducer = AddTaskReducer()
    @Published var state: AddTaskState

    init(state: AddTaskState) {
        self.state = state
    }

    func dispatch(_ action: AddTaskAction) {
        self.debug("AddTaskStore: \(action)")
        self.reducer.reduce(&self.state, action)
    }

    private func debug(_ msg: String) {
        print("[AddTaskStore]: \(msg)")
    }
}

private final class AddTaskReducer {
    func reduce(_ state: inout AddTaskState, _ action: AddTaskAction) {
        switch action {
        case .didChangeTitle(let title):
            state.title = title
        }
    }
}
