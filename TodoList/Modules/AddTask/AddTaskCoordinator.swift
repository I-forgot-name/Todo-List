//
//  AddTaskCoordinator.swift
//  TodoList
//
//  Created by MacBook Pro on 28.02.2023.
//

import SwiftUI
import Swinject

final class AddTaskCoordinator {

    private let assembler: Assembler

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }
    func start() -> some View {
        let state = AddTaskState()
        let store = AddTaskStore(state: state)
        let view = AddTaskContentView().environmentObject(store)
        return view
    }
}
