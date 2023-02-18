//
//  TaskCell.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

import SwiftUI

struct TaskCellModel {
    let title: String
    let isOn: Bool
}

struct TaskCell: View {
    let model: TaskCellModel
    var didTapChackmark: () -> Void

    var body: some View {
        HStack {
            Image(systemName: model.isOn ? "checkmark.circle.fill": "checkmark.circle")
                .onTapGesture {
                    didTapChackmark()
                }
            Text(model.title)
        }
    }
}
