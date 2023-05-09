//
//  MockAddTaskReducer.swift
//  TodoListTests
//
//  Created by MacBook Pro on 09.05.2023.
//

final class MockAddTaskReducer: IAddTaskReducer {

    var invokedReduce = false
    var invokedReduceCount = 0
    var invokedReduceParameters: (state: AddTaskState, action: AddTaskAction)?
    var invokedReduceParametersList = [(state: AddTaskState, action: AddTaskAction)]()

    func reduce(_ state: inout AddTaskState, _ action: AddTaskAction) {
        invokedReduce = true
        invokedReduceCount += 1
        invokedReduceParameters = (state, action)
        invokedReduceParametersList.append((state, action))
    }
}
