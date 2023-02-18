//
//  MainState.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

struct MainState: Equatable {
    var tasks: [MainTaskModel] = [.init(id: 1, title: "Хлеб", isOn: true), .init(id: 2, title: "Вода", isOn: false)]
    var title = ""
}
