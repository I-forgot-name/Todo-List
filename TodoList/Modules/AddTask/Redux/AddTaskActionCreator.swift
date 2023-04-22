//
//  AddTaskActionCreator.swift
//  TodoList
//
//  Created by MacBook Pro on 26.02.2023.
//
import Combine

final class AddTaskActionCreator {
    private weak var store: AddTaskStore?
    private let service: ITasksService
    private var cancelBag = Set<AnyCancellable>()

    private let repository: DBRepository<TaskDomainModel, TaskEntity>

    init(
        store: AddTaskStore,
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
        repository.save([model]) { [weak self] result in
            guard let store = self?.store else { return }
            switch result {
            case .success:
                store.dispatch(.completeAddTask)
            case .failure(let error):
                print("=== [save] \(model.self) is - error(\(error)")
            }
        }
    }
}
