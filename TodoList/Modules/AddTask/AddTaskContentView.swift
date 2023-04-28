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
    @Environment(\.presentationMode) var presentationMode

    init(ac: AddTaskActionCreator) {
        self.ac = ac
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Title", text: $text)
                        .onChange(of: text, perform: { newValue in
                            store.dispatch(.didChangeTitle(text))
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .navigationTitle("Create task")
                }

                Spacer()

                Button {
                    store.dispatch(.didTapCreate)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Create")
                }
                .padding()
                .background(Color.main)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .font(.bold(.title3)())

            }
            .padding(.horizontal, 20)
        }
    }
}
