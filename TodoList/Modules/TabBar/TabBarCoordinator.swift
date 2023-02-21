//
//  TabBarCoordinator.swift
//  TodoList
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import Swinject

final class TabBarCoordinator {

    private let assembler: Assembler
    
    private let mainCoordinator: MainCoordinator

    @State private var routing: TabBar.Routing = .main

    init(_ assembler: Assembler) {
        self.assembler = assembler
        mainCoordinator = .init(assembler)
    }
    func start() -> some View {
        let state = TabBarState()
        let store = TabBarStore(state: state)
        let view = TabBar(mainCoordinator: mainCoordinator, tabBarStore: store)
        bind(view: view)
        return view
    }

    private func bind(view: TabBar) {
        switch view.routing {
        case .main:
            print("main")
        case .addTask:
            print("addTask")
        }
    }
}
