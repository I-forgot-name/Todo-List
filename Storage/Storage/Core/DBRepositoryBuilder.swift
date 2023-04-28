//
//  DBRepositoryBuilder.swift
//  TodoList
//
//  Created by MacBook Pro on 23.04.2023.
//

public struct StorageCoreBuilder<DomainModel, DBEntity> {
    
    public static func make(
        contextProvider: IContextProvider,
        request: IStorageSearchRequest,
        mapper: EntityMapper<DomainModel, DBEntity>
    ) -> StorageCore<DomainModel, DBEntity> {
        StorageCore(
            contextProvider: contextProvider,
            autoUpdateSearchRequest: request,
            entityMapper: mapper
        )
    }
}
