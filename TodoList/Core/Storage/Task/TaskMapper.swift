//
//  TaskMapper.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData

final class TaskEntityMapper: DBEntityMapper<TaskDomainModel,  TaskEntity> {
    override func convert(_ entity: TaskEntity) -> TaskDomainModel? {
        return TaskDomainModel(
            id: entity.id ?? "",
            title: entity.title ?? "",
            isComplete: entity.isComplete
        )
    }

    override func update(_ entity: TaskEntity, by model: TaskDomainModel) {
        entity.id = model.id
        entity.title = model.title
        entity.isComplete = model.isComplete
    }

    override func entityAccessorKey(_ entity: TaskEntity) -> String {
        entity.id ?? "-1"
    }

    override func entityAccessorKey(_ object: TaskDomainModel) -> String {
        object.id
    }
}



