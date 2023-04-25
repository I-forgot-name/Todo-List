//
//  DBRepositoryBuilder.swift
//  TodoList
//
//  Created by MacBook Pro on 23.04.2023.
//

import Swinject
import CoreData

struct DBRepositoryBuilder<DomainModel, DBEntity> {
    
    static func make(
        contextProvider: IDBContextProvider,
        mapper: DBEntityMapper<DomainModel, DBEntity>
    ) -> DBRepository<DomainModel, DBEntity> {
        return DBRepository(
            contextProvider: contextProvider,
            entityMapper: mapper
        )
    }
}
