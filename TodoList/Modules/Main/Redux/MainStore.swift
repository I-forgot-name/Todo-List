//
//  MainStore.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import Foundation

enum MainAction {
    case onAppear
    case didTapCheckmark(id: String)

    case completeLoadTasks(Result<[MainTaskModel], Error>)
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
            updateLoadingStatus(.load, in: &state)
            state.title = "Appear"
        case .didTapCheckmark(let id):
            guard let index = state.tasks.firstIndex(where: { model in
                model.id == id
            }) else {
                return
            }

            state.tasks[index].isComplete.toggle()
        case .completeLoadTasks(let result):
            handleResultLoad(for: result, in: &state)
        }
    }

    private func updateLoadingStatus(
        _ status: MainState.LoadingStatus,
        in state: inout MainState
    ) {
        guard state.loadingStatus != status else { return }
        state.loadingStatus = status
    }

    private func handleResultLoad(
        for result: Result<[MainTaskModel], Error>,
        in state: inout MainState
    ) {

        switch result {
        case .success(let tasks):
            state.tasks = tasks
            updateLoadingStatus(.idle, in: &state)
        case .failure(let error):
            updateLoadingStatus(.error, in: &state)
        }
    }
}
