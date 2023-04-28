//
//  MainContentViewBuilder.swift
//  TodoList
//
//  Created by MacBook Pro on 23.04.2023.
//
import Swinject
import SwiftUI
import Storage

struct MainContentViewBuilder {

    //    MARK: Properties

    private let assembler: Assembler
    private let addTaskCoordinator: AddTaskCoordinator

    //    MARK: Init

    init(_ assembler: Assembler) {
        self.assembler = assembler
        addTaskCoordinator = AddTaskCoordinator(assembler)
    }

    //    MARK: Functions

    func build() -> some View {
        let state = MainState()
        let store = MainStore(state: state)

        let ac = MainActionCreatorBuilder(assembler).build(store: store)
        let cv = MainContentView(ac: ac, addTaskCoordinator: addTaskCoordinator).environmentObject(store)
        return cv
    }
}
