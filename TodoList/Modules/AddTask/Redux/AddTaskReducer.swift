//
//  AddTaskReducer.swift
//  TodoList
//
//  Created by MacBook Pro on 10.05.2023.
//

protocol IAddTaskReducer {
    func reduce(_ state: inout AddTaskState, _ action: AddTaskAction)
}

final class AddTaskReducer {
    private func updateAddTaskStatus(
        _ status: AddTaskState.AddTaskStatus,
        in state: inout AddTaskState
    ) {
        guard state.addTaskStatus != status else { return }
        state.addTaskStatus = status
    }
}

extension AddTaskReducer: IAddTaskReducer {
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
}

