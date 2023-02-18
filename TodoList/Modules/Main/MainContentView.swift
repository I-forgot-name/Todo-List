//
//  MainContentView.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI

struct MainContentView: View {

    @EnvironmentObject var store: MainStore

    var body: some View {
        List (store.state.tasks, id: \.self) { task in
            TaskCell(model: TaskCellModel.init(title: task.title, isOn: task.isOn)) {
                store.dispatch(.didTapCheckmark(task.id))
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
