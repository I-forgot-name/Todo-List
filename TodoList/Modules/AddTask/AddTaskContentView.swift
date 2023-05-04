//
//  AddTaskContentView.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//

import SwiftUI
import Combine

struct AddTaskContentView: View {
    @EnvironmentObject private var store: AddTaskStore
    private let ac: AddTaskActionCreator
    private weak var addTaskCoordinator: AddTaskCoordinator?
    @State var text: String = ""

    init(ac: AddTaskActionCreator, addTaskCoordinator: AddTaskCoordinator?) {
        self.ac = ac
        self.addTaskCoordinator = addTaskCoordinator
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $store.state.title)
                    .onChange(of: text, perform: { newValue in
                        store.dispatch(.didChangeTitle(text))
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(20)

            MainButton(title: "Create"){
                store.dispatch(.didTapCreate)
            }
            .padding(.bottom, 20)
        }

        .background(.white)
    }
}
