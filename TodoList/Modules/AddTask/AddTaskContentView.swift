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
    @State var text: String = ""

    init(ac: AddTaskActionCreator) {
        self.ac = ac
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
