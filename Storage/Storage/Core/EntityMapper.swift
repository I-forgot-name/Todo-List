//
//  EntityMapper.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

open class EntityMapper<DomainModel, Entity> {

    public init() {}

    open func convert(_ entity: Entity) -> DomainModel? {
        fatalError("convert(_ entity: Entity: must be overrided")
    }

    open func update(_ entity: Entity, by model: DomainModel) {
        fatalError("supdate(_ entity: Entity: must be overrided")
    }

    open func entityAccessorKey(_ entity: Entity) -> String {
        fatalError("entityAccessorKey must be overrided")
    }

    open func entityAccessorKey(_ object: DomainModel) -> String {
        fatalError("entityAccessorKey must be overrided")
    }
}
