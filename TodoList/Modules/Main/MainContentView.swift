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
            VStack {
                List {
                    Section (footer:
                                GeometryReader { geo in
                        HStack (alignment: .center) {
                            MainButton(title: L10n.Main.Button.addTask) {
                                isPresented.toggle()
                            }
                            .sheet(isPresented: $isPresented) {
                                addTaskCoordinator.start()
                            }
                        }
                        .frame(maxWidth: geo.size.width, minHeight: geo.size.height)
                    }
                    .frame(minHeight: 60)


                    ) {
                        ForEach(store.state.tasks, id: \.self) { task in
                            TaskCell(model: TaskCellModel.init(title: task.title, isOn: task.isComplete)) {
                                store.dispatch(.didTapCheckmark(id: task.id))
                            }
                        }
                    }

                    Section {

                    }
                }
                .listStyle(.insetGrouped)
                .onAppear {
                    UITableView.appearance().backgroundColor = .appBlue.withAlphaComponent(0.1)
                }
            }
            .navigationTitle(L10n.Main.Title.yourTask)
        }
        .background(Color.red)
        .onAppear {
            store.dispatch(.onAppear)
        }
    }
}
