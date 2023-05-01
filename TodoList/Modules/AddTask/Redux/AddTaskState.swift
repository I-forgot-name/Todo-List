//
//  AddTaskState.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

import Foundation

struct AddTaskState: Equatable {
    enum AddTaskStatus: Equatable {
        case idle
        case load
        case error
    }
    var id: String = UUID().uuidString
    var title: String = ""
    var isComplete: Bool = false
    var taskDomainModel: TaskDomainModel {
        .init(
            id: id,
            title: title,
            isComplete: isComplete,
            timestamp: Date()
        )
    }

    var addTaskStatus: AddTaskStatus = .idle
}
