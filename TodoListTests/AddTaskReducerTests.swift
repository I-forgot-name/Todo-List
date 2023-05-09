//
//  AddTaskReducerTests.swift
//  TodoListTests
//
//  Created by MacBook Pro on 09.05.2023.
//

import XCTest
@testable import TodoList

class AddTaskReducerTests: XCTestCase {

    var reducer: IAddTaskReducer!
    var state: AddTaskState!

    override func setUp() {
        super.setUp()
        reducer = AddTaskReducer()
        state = AddTaskState()
    }

    override func tearDown() {
        super.tearDown()
        reducer = nil
        state = nil
    }

    func testDidChangeTitle() throws {
        var title: String
        title = "test"

        reducer.reduce(&state, .didChangeTitle(title))

        XCTAssertEqual(title, state.title)
    }

    func testDidTapCreate() throws {
        reducer.reduce(&state, .didTapCreate)

        XCTAssertEqual(.load, state.addTaskStatus)
    }

    func testCompleteAddTask() throws {
        reducer.reduce(&state, .completeAddTask)

        XCTAssertEqual(.idle, state.addTaskStatus)
        XCTAssertEqual("", state.title)
    }
}
