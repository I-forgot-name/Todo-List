//
//  MainStore.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import Foundation
import Combine

enum MainAction {
    case didTapCheckmark(id: String)

    case tasksStorageChanched([MainTaskModel])
}

// MARK: MainStore

final class MainStore: ObservableObject {
    private var reducer = MainReducer()
    
    @Published var state: MainState

    init(state: MainState) {
        self.state = state
    }
    
    func dispatch(_ action: MainAction) {
        self.debug("action: \(action)")
        self.reducer.reduce(&self.state, action)
       }
    
    private func debug(_ msg: String) {
        print("[MainStore]: \(msg)")
    }
}

// MARK: MainReducer

private final class MainReducer {
    func reduce(_ state: inout MainState, _ action: MainAction) {
        switch action {
        case .didTapCheckmark(let id):
            guard let index = state.tasks.firstIndex(where: { model in
                model.id == id
            }) else {
                return
            }

            state.tasks[index].isComplete.toggle()
        case .tasksStorageChanched(let tasks):
            state.tasks = tasks.sorted { $0.timestamp > $1.timestamp }
        }
    }
}
