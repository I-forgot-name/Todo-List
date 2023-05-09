//
//  AddTaskStoreTests.swift
//  TodoListTests
//
//  Created by MacBook Pro on 09.05.2023.
//

import XCTest
@testable import TodoList

class AddTaskStoreTests: XCTestCase {

    var store: AddTaskStore!
    var reducer: MockAddTaskReducer!
    var state: AddTaskState!

    override func setUp() {
        super.setUp()
        reducer = MockAddTaskReducer()
        state = AddTaskState()
        store = .init(state: state, reducer: reducer)
    }

    override func tearDown() {
        super.tearDown()

        store = nil
        reducer = nil
        state = nil
    }

    func testDispatch() throws {
        XCTAssertEqual(0, reducer.invokedReduceCount)

        store.dispatch(.completeAddTask)
        XCTAssertEqual(1, reducer.invokedReduceCount)
        XCTAssertEqual(reducer.invokedReduceParameters!.state, state)
        XCTAssertEqual(reducer.invokedReduceParameters!.action, .completeAddTask)

        store.dispatch(.didTapCreate)
        XCTAssertEqual(2, reducer.invokedReduceCount)
        XCTAssertEqual(reducer.invokedReduceParameters!.state, state)
        XCTAssertEqual(reducer.invokedReduceParameters!.action, .didTapCreate)

        let title = "test"
        store.dispatch(.didChangeTitle(title))
        XCTAssertEqual(3, reducer.invokedReduceCount)
        XCTAssertEqual(reducer.invokedReduceParameters!.state, state)
        XCTAssertEqual(reducer.invokedReduceParameters!.action, .didChangeTitle(title))
    }
}
