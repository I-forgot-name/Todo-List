//
//  DBRepository.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData
import Foundation

final class DBRepository<DomainModel, DBEntity>: NSObject, IRepository, NSFetchedResultsControllerDelegate {

    typealias DomainModel = DomainModel

    private let associatedEntityName: String
    private let contextProvider: IDBContextProvider
    private let entityMapper: DBEntityMapper<DomainModel, DBEntity>

    // MARK: - Init

    init(
        contextProvider: IDBContextProvider,
        entityMapper: DBEntityMapper<DomainModel, DBEntity>
    ) {
        self.contextProvider = contextProvider
        self.associatedEntityName = String(describing: DBEntity.self)
        self.entityMapper = entityMapper
    }

    func save(
        _ objects: [DomainModel],
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        saveIn(
            data: objects,
            clearBeforeSaving: nil,
            completion: completion
        )
    }

    func save(
        _ objects: [DomainModel],
        clearBeforeSaving: IRepositorySearchRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        saveIn(
            data: objects,
            clearBeforeSaving: clearBeforeSaving,
            completion: completion
        )
    }

    func present(
        by request: IRepositorySearchRequest,
        completion: @escaping (Result<[DomainModel], Error>) -> Void
    ) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: associatedEntityName)
        fetchRequest.predicate = request.predicate
        fetchRequest.sortDescriptors = request.sortDescriptors
        contextProvider.newBackgroundContext { context in
            do {
                let rawData = try context.fetch(fetchRequest)
                guard rawData.isEmpty == false else {return completion(.success([])) }
                guard let results = rawData as? [DBEntity] else {
                    completion(.success([]))
                    assertionFailure(DBRepositoryError.entityTypeError.localizedDescription)
                    return
                }

                let converted = results.compactMap({ return self.entityMapper.convert($0) })
                completion(.success(converted))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func delete(
        by request: IRepositorySearchRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: associatedEntityName)
        fetchRequest.predicate = request.predicate
        fetchRequest.includesPropertyValues = false
        contextProvider.newBackgroundContext { context in
            let results = try? context.fetch(fetchRequest)
            results?.forEach({ context.delete($0) })
            self.applyChanges(context: context, completion: completion)
        }
    }

    func eraseAllData(completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: associatedEntityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        batchDeleteRequest.resultType = .resultTypeObjectIDs
        contextProvider.newBackgroundContext { [weak self] in
            guard let self = self else { return }
            do {
                let result = try $0.execute(batchDeleteRequest)
                guard let deleteResult = result as? NSBatchDeleteResult,
                      let ids = deleteResult.result as? [NSManagedObjectID]
                else {
                    completion(.failure(DBRepositoryError.noChangesInRepository))
                    return
                }

                let changes = [NSDeletedObjectsKey: ids]
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: changes,
                    into: [self.contextProvider.mainQueueContext()]
                )

                completion(.success(()))
                return
            } catch {
                print("\n[DBRepository - \(DBEntity.self)]\n", "method: eraseAllData\n", "Error: \(error)\n\n")
                completion(.failure(error))
            }
        }
    }
}

extension DBRepository {

    private func applyChanges(
        context: NSManagedObjectContext,
        mergePolicy: Any = NSMergeByPropertyObjectTrumpMergePolicy,
        completion: ((Result<Void, Error>) -> Void)?
    ) {
        context.mergePolicy = mergePolicy
        switch context.hasChanges {
        case true:
            do {
                try context.save()
            } catch {
                print("\n[DBRepository - \(DBEntity.self)]\n", "method: saveIn\n", "Error: \(error)\n\n")
                completion?(.failure(error))
            }
            print("\n[DBRepository - \(DBEntity.self)]\n", "method: saveIn\n", "Saving Complete\n\n")
            completion?(.success(()))
        case false:
            print("[DBRepository - \(DBEntity.self)]\n", "method: saveIn\n", "No changes in context\n\n")
            completion?(.failure(DBRepositoryError.noChangesInRepository))
        }
    }

    private func saveIn(
        data: [DomainModel],
        clearBeforeSaving: IRepositorySearchRequest?,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        contextProvider.newBackgroundContext { context in
            if let clearBeforeSaving = clearBeforeSaving {
                let clearFetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.associatedEntityName)
                clearFetchRequest.predicate = clearBeforeSaving.predicate
                clearFetchRequest.includesPropertyValues = false
                (try? context.fetch(clearFetchRequest))?.forEach({ context.delete($0) })
            }

            var existingObjects: [String: DBEntity] = [:]
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.associatedEntityName)

            (try? context.fetch(fetchRequest) as? [DBEntity])?.forEach({
                let accessor = self.entityMapper.entityAccessorKey($0)
                existingObjects[accessor] = $0
            })

            data.forEach({
                let accessor = self.entityMapper.entityAccessorKey($0)
                let entityForUpdate: DBEntity? = existingObjects[accessor] ?? NSEntityDescription.insertNewObject(
                    forEntityName: self.associatedEntityName,
                    into: context
                ) as? DBEntity
                guard let entity = entityForUpdate else { return }
                self.entityMapper.update(entity, by: $0)
            })
            self.applyChanges(context: context, completion: completion)
        }
    }
}
