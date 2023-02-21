//
//  TabBarStore.swift
//  TodoList
//
//  Created by MacBook Pro on 19.02.2023.
//

import Foundation

enum TabBarAction {
    case changeTab(TabBarState.Tab)
}

final class TabBarStore: ObservableObject {
    private var reducer = TabBarActionReducer()
    @Published var state: TabBarState

    init(state: TabBarState) {
        self.state = state
    }

    func dispatch(_ action: TabBarAction) {
        self.debug("action: \(action)")
        self.reducer.reduce(&self.state, action)
    }

    private func debug(_ msg: String) {
        print("[MainStore]: \(msg)")
    }
}

private final class TabBarActionReducer {
    func reduce(_ state: inout TabBarState, _ action: TabBarAction) {
        switch action {
        case .changeTab(let tab):
            guard state.tab != tab else { return }
            state.tab = tab
        }
    }

}
