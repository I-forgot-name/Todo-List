//
//  IRepositorySearchRequest.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData

protocol IRepositorySearchRequest {

    /// Условие для выборки
    var predicate: NSPredicate? { get }

    /// Условие сортировки
    var sortDescriptors: [NSSortDescriptor] { get }
}
