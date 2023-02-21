//
//  TabBarState.swift
//  TodoList
//
//  Created by MacBook Pro on 19.02.2023.
//

struct TabBarState: Equatable {
    enum Tab: Equatable {
        case main
        case profile
    }
    var tab: Tab = .main
}
