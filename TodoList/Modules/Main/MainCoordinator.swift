//
//  MainCoordinator.swift
//  BooksReview
//
//  Created by MacBook Pro on 19.02.2023.
//

import SwiftUI
import Swinject
import Storage

final class MainCoordinator {
    private let assembler: Assembler

    init(_ assembler: Assembler) {
        self.assembler = assembler
    }

    func start() -> some View {
        MainContentViewBuilder(assembler).build()
    }
}
