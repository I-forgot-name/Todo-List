//
//  AddTaskStateTests.swift
//  TodoListTests
//
//  Created by MacBook Pro on 09.05.2023.
//

import XCTest
@testable import struct TodoList.AddTaskState

class AddTaskStateTests: XCTestCase {

    var state: AddTaskState!

    override func setUp() {
        super.setUp()
        state = .init()
    }

    override func tearDown() {
        state = nil
        super.tearDown()
    }

    func testCreateDomainModel() throws {
        XCTAssertEqual(state.id, state.taskDomainModel.id)
        XCTAssertEqual(state.title, state.taskDomainModel.title)
        XCTAssertEqual(state.isComplete, state.taskDomainModel.isComplete)
        XCTAssertEqual(state.date, state.taskDomainModel.timestamp)
    }
}
