//
//  TaskResponseModel.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

struct TaskResponseModel: Decodable {
    let id: String
    let title: String
    let isComplete: Bool

    init(_ dict: [String: Any], id: String) {
        guard let title = dict["title"] as? String,
              let isComplete = dict["isComplete"] as? Bool else {
            fatalError("Error when decode")
            }
        self.id = id
        self.title = title
        self.isComplete = isComplete
    }
}
