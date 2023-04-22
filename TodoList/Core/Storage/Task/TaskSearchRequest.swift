//
//  TaskSearchRequest.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData

private struct Constants {

}

struct TaskSearchRequest: IRepositorySearchRequest {
    var predicate: NSPredicate?

    var sortDescriptors: [NSSortDescriptor] = []

    init() {
//        predicate = NSPredicate(format: )
    }
}
