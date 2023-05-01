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

//    enum RequestType {
//        case get
//        case delete
//    }
//
//    static func request(by type: RequestType) -> IStorageSearchRequest {
//        switch type {
//        case .get
//        }
//    }
}
