//
//  MainCoordinator.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI

final class MainCoordinator {
    func start() -> some View {
        let state = MainState()
        let store = MainStore(state: state)
        return MainContentView().environmentObject(store)
    }
}
