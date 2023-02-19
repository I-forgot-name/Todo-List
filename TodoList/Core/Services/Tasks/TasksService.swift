//
//  TasksService.swift
//  TodoList
//
//  Created by MacBook Pro on 18.02.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ITasksService {
    func getTasks(_ completion: @escaping (Result<[TaskResponseModel], Error>) -> Void)
}

final class TasksService: ITasksService {

    private let tasksDB = Firestore.firestore().collection("Tasks")
    
    func getTasks(_ completion: @escaping (Result<[TaskResponseModel], Error>) -> Void) {
        tasksDB.getDocuments(source: .default) { result, error in
            let tasks: [TaskResponseModel] = result!.documents.map { .init($0.data(), id: $0.documentID) }
            completion(.success(tasks))
        }
    }

}
