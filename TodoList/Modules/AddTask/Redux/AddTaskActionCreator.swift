//
//  AddTaskActionCreator.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//
import Combine
import SwiftUI
import Storage

final class AddTaskActionCreator {
    private weak var store: AddTaskStore?
    private let service: ITasksService
    private var cancelBag = Set<AnyCancellable>()

    private let storage: StorageCore<TaskDomainModel, TaskEntity>
    
    init(
        store: AddTaskStore,
        service: ITasksService,
        storage: StorageCore<TaskDomainModel, TaskEntity>
    ) {
        self.store = store
        self.service = service
        self.storage = storage
        bind()
    }

    private func bind() {
        store?.$state
            .removeDuplicates(by: { first, second in
                first.addTaskStatus == second.addTaskStatus
            })
            .sink { [weak self] in
                guard let self = self else { return }
                switch $0.addTaskStatus {
                case .load:
                    self.add(task: $0.taskDomainModel)
                default:
                    return
                }
            }
            .store(in: &cancelBag)
    }

    func add(task model: TaskDomainModel) {
        storage.save([model])
        store?.dispatch(.completeAddTask)
    }
}
