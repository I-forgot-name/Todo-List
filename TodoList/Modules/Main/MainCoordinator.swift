//
//  MainCoordinator.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import Swinject

final class MainCoordinator {
    private let assembler: Assembler

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }
    func start() -> some View {
        let state = MainState()
        let store = MainStore(state: state)
        let ac = MainActionCreator(store: store, service: assembler.resolver.resolve(ITasksService.self)!)
        return MainContentView(ac: ac).environmentObject(store)
    }
}
