//
//  DBEntityMapper.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

class DBEntityMapper<DomainModel, Entity> {

   func convert(_ entity: Entity) -> DomainModel? {
      fatalError("convert(_ entity: Entity: must be overrided")
   }

   func update(_ entity: Entity, by model: DomainModel) {
      fatalError("supdate(_ entity: Entity: must be overrided")
   }

   func entityAccessorKey(_ entity: Entity) -> String {
      fatalError("entityAccessorKey must be overrided")
   }

   func entityAccessorKey(_ object: DomainModel) -> String {
      fatalError("entityAccessorKey must be overrided")
   }
}
