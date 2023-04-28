//
//  MainList.swift
//  TodoList
//
//  Created by MacBook Pro on 28.04.2023.
//

import SwiftUI

struct MainList: View {
    var models: [MainTaskModel]
    @Binding var isPresented: Bool
    var didTapChackmark: (_ id: String) -> Void
    var delete: (_ task: MainTaskModel) -> Void


    var body: some View {
        VStack {
            List {
                Section (
                    footer: HStack () {
                        Spacer()
                        MainButton(title: L10n.Main.Button.addTask) {
                            isPresented.toggle()
                        }
                        Spacer()
                    }
                        .frame(height: 60)) {
                            ForEach(models, id: \.self) { task in
                                TaskCell(model: TaskCellModel.init(title: task.title, isOn: task.isComplete)) {
                                    didTapChackmark(task.id)
                                }
                                .swipeActions(allowsFullSwipe: true) {
                                    Button {
                                        delete(task)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
            }
            .listStyle(.insetGrouped)
            .onAppear {
                UITableView.appearance().backgroundColor = .appBlue.withAlphaComponent(0.1)
            }
        }
    }
}
