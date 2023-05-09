//
//  AddTaskStore.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

import Foundation

enum AddTaskAction: Equatable {
    case didChangeTitle(String)
    case didTapCreate

    case completeAddTask
}

final class AddTaskStore: ObservableObject {
    private var reducer: IAddTaskReducer
    @Published var state: AddTaskState

    init(state: AddTaskState, reducer: IAddTaskReducer) {
        self.state = state
        self.reducer = reducer
    }

    func dispatch(_ action: AddTaskAction) {
        self.debug("action: \(action)")
        self.reducer.reduce(&self.state, action)
    }

    private func debug(_ msg: String) {
        print("[AddTaskStore]: \(msg)")
    }
}
