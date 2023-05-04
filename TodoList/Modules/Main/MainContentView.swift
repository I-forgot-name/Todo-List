//
//  MainContentView.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import UICore

struct MainContentView: View {
    
    @EnvironmentObject private var store: MainStore
    private let ac: MainActionCreator
    private let mainCoordinator: MainCoordinator

    @State private var isPresented = false


    init(ac: MainActionCreator, mainCoordinator: MainCoordinator) {
        self.ac = ac
        self.mainCoordinator = mainCoordinator
    }

    var body: some View {
        NavigationView {
            MainList(
                models: store.state.tasks,
                isPresented: $isPresented
            ) {
                store.dispatch(.didTapCheckmark(id: $0))
            } delete: {
                ac.delete(id: $0.id)
            }
            .navigationTitle(L10n.Main.Title.yourTask)
        }
        .background(Color.red)
        .popup(
            isPresented: $isPresented,
            alignment: .bottom,
            direction: .bottom,
            needShadow: true,
            content: {
                mainCoordinator.addTask()
            }
        )
    }
}
