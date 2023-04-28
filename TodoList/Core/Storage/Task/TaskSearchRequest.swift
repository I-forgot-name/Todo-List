//
//  TaskSearchRequest.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import Storage

private struct Constants {

}

struct TaskSearchRequest: IStorageSearchRequest {
    var predicate: NSPredicate?

    var sortDescriptors: [NSSortDescriptor] = []
}
