//
//  MainActionCreator.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

import Combine
import SwiftUI
import Storage

final class MainActionCreator {
    private weak var store: MainStore?
    private var cancelBag = Set<AnyCancellable>()

    @Published private var storage: StorageCore<TaskDomainModel, TaskEntity>

    // MARK: - Init

    init(
        store: MainStore,
        storage: StorageCore<TaskDomainModel, TaskEntity>
    ) {
        self.store = store
        self.storage = storage
        bind()
    }

    private func bind() {
        storage.$actualData.sink { [weak self] tasks in
            guard let store = self?.store else { return }
            let tasks: [MainTaskModel] = tasks.map { .init($0) }
            store.dispatch(.tasksStorageChanched(tasks))
        }
        .store(in: &cancelBag)
    }
}
