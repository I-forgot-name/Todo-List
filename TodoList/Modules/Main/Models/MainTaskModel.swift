//
//  MainTaskModel.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

struct MainTaskModel: Equatable, Hashable {
    let id: String
    let title: String
    var isComplete: Bool

    init(_ model: TaskDomainModel) {
        id = model.id
        title = model.title
        isComplete = model.isComplete
    }
}
