//
//  MainContentView.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI

struct MainContentView: View {
    
    @EnvironmentObject private var store: MainStore
    private let ac: MainActionCreator
    private let addTaskCoordinator: AddTaskCoordinator

    @State private var isPresented = false


    init(ac: MainActionCreator, addTaskCoordinator: AddTaskCoordinator) {
        self.ac = ac
        self.addTaskCoordinator = addTaskCoordinator
    }

    var body: some View {
        NavigationView {
            MainList(models: store.state.tasks, isPresented: $isPresented) {
                store.dispatch(.didTapCheckmark(id: $0))
            } delete: {
                ac.delete(id: $0.id)
            }
            .navigationTitle(L10n.Main.Title.yourTask)
        }
        .background(Color.red)
        .sheet(isPresented: $isPresented) {
            addTaskCoordinator.start()
            
        }
    }
}
