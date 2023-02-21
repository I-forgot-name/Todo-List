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


    init(ac: MainActionCreator) {
        self.ac = ac
    }

    var body: some View {
        NavigationView {
            VStack {
                List (store.state.tasks, id: \.self) { task in
                    TaskCell(model: TaskCellModel.init(title: task.title, isOn: task.isComplete)) {
                        store.dispatch(.didTapCheckmark(id: task.id))
                    }
                }
            }
            .navigationTitle(L10n.Main.Title.yourTask)
        }
        .onAppear {
            store.dispatch(.onAppear)
        }
    }
}
