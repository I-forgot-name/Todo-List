//
//  MainState.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

struct MainState: Equatable {
    enum LoadingStatus: Equatable {
        case idle
        case load
        case error
    }
    var loadingStatus: LoadingStatus = LoadingStatus.idle
    var tasks: [MainTaskModel] = []
}
