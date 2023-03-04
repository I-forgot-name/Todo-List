//
//  AddTaskState.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

struct AddTaskState: Equatable {
    enum AddTaskStatus: Equatable {
        case idle
        case load
        case error
    }
    var title: String = ""
    var addTaskStatus: AddTaskStatus = .idle
}
