//
//  MainStore.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import Foundation

enum MainAction {
    case onAppear
    case didTapCheckmark(Int)
}

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

private final class MainReducer {
    func reduce(_ state: inout MainState, _ action: MainAction) {
        switch action {
        case .onAppear:
            state.title = "Appear"
        case .didTapCheckmark(let id):
            guard let index = state.tasks.firstIndex(where: { model in
                model.id == id
            }) else {
                return
            }

            state.tasks[index].isOn.toggle()
        }
    }
}
