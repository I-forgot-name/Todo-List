//
//  AddTaskStore.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

import Foundation

enum AddTaskAction {
    case didChangeTitle(String)
    case didTapCreate

    case completeAddTask
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
        case .didTapCreate:
            updateAddTaskStatus(.load, in: &state)
        case .completeAddTask:
            updateAddTaskStatus(.idle, in: &state)
            state.title = ""
        }
    }

    private func updateAddTaskStatus(
        _ status: AddTaskState.AddTaskStatus,
        in state: inout AddTaskState
    ) {
        guard state.addTaskStatus != status else { return }
        state.addTaskStatus = status
    }
}
