//
//  MainCoordinator.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import Swinject
import Storage

final class MainCoordinator {
    private let assembler: Assembler

    private let addTaskCoordinator: AddTaskCoordinator

    init(_ assembler: Assembler) {
        self.assembler = assembler
        addTaskCoordinator = .init(assembler)
    }

    func start() -> some View {
        let state = MainState()
        let store = MainStore(state: state)

        let ac = MainActionCreatorBuilder(assembler).build(store: store)
        let cv = MainContentView(ac: ac, mainCoordinator: self).environmentObject(store)
        return cv
    }

    func addTask() -> some View {
        addTaskCoordinator.start()
    }
}
