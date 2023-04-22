//
//  MainActionCreator.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

import Combine
import Foundation

final class MainActionCreator {
    private weak var store: MainStore?
    private let service: ITasksService
    private var cancelBag = Set<AnyCancellable>()

    private let repository: DBRepository<TaskDomainModel, TaskEntity>

    // MARK: - Init

    init(
        store: MainStore,
        service: ITasksService,
        repository: DBRepository<TaskDomainModel, TaskEntity>
    ) {
        self.store = store
        self.service = service
        self.repository = repository
        bind()
    }

    private func bind() {
        store?.$state
            .removeDuplicates(by: { first, second in
                first.loadingStatus == second.loadingStatus
            })
            .sink { [weak self] in
                guard let self = self else { return }
                switch $0.loadingStatus {
                case .load:
                    self.getTasks()
                default:
                    return
                }
            }
            .store(in: &cancelBag)
    }

    func getTasks() {
        repository.present(by: TaskSearchRequest()) { [weak self] result in
            guard let store = self?.store else {
                return
            }
            switch result {
            case .success(let tasks):
                let tasks: [MainTaskModel] = tasks.map { .init($0) }
                    store.dispatch(.completeLoadTasks(.success(tasks)))
            case .failure(let error):
                print(error)
            }
        }
    }



//    func getTasks() {
//        service.getTasks { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let tasks):
//                let tasks: [MainTaskModel] = tasks.map { .init($0) }
//                self.store?.dispatch(.completeLoadTasks(.success(tasks)))
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
