//
//  StorageCore.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

import CoreData
import Foundation

public final class StorageCore<DomainModel, DBEntity>: NSObject, IStorageCore, ObservableObject, NSFetchedResultsControllerDelegate {

    public typealias DomainModel = DomainModel

    @Published public var actualData: [DomainModel] = []

    //    Published var searchedData: [DomainModel] = []

    private let associatedEntityName: String
    private let contextProvider: IContextProvider
    private let entityMapper: EntityMapper<DomainModel, DBEntity>
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    

    // MARK: - Init

    public init(
        contextProvider: IContextProvider,
        autoUpdateSearchRequest: IStorageSearchRequest?,
        entityMapper: EntityMapper<DomainModel, DBEntity>
    ) {
        self.contextProvider = contextProvider
        self.associatedEntityName = String(describing: DBEntity.self)
        self.entityMapper = entityMapper

        super.init()

        guard let request = autoUpdateSearchRequest else {
            return
        }
        self.fetchedResultsController = configureactualSearchedDataUpdating(request)
    }

    private func configureactualSearchedDataUpdating(_ request: IStorageSearchRequest) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: associatedEntityName)

        fetchRequest.predicate = request.predicate
        fetchRequest.sortDescriptors = request.sortDescriptors

        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: contextProvider.mainQueueContext(),
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        if let content = fetchedResultsController.fetchedObjects as? [DBEntity] {
            updateObservableContent(content)
        }
        return fetchedResultsController
    }

    func updateObservableContent(_ content: [DBEntity]) {
        let converted = content.compactMap({ return self.entityMapper.convert($0) })
        actualData = converted
    }


    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let dataFetched = controller.fetchedObjects as? [DBEntity] else {
            return
        }
        let converted = dataFetched.compactMap({ return self.entityMapper.convert($0) })

        actualData = converted
    }

    public func save(_ objects: [DomainModel]) {
        saveIn(data: objects)
    }

    public func present(
        by request: IStorageSearchRequest
    ) -> Result<[DomainModel], Error> {

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: associatedEntityName)
        fetchRequest.predicate = request.predicate
        fetchRequest.sortDescriptors = request.sortDescriptors

        let context = contextProvider.mainQueueContext()
        do {
            let rawData = try context.fetch(fetchRequest)
            guard rawData.isEmpty == false else {return (.success([])) }
            guard let results = rawData as? [DBEntity] else {
                assertionFailure(DBError.entityTypeError.localizedDescription)
                return(.success([]))
            }

            let converted = results.compactMap({ return self.entityMapper.convert($0) })
            return(.success(converted))
        } catch {
            return(.failure(error))
        }
    }

    public func delete(by request: IStorageSearchRequest) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: associatedEntityName)
        fetchRequest.predicate = request.predicate
        fetchRequest.includesPropertyValues = false
        let context = contextProvider.mainQueueContext()

        let results = try? context.fetch(fetchRequest)
        results?.forEach({ context.delete($0) })
        context.saveContext()
    }

    public func eraseAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: associatedEntityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let context = contextProvider.mainQueueContext()

        do {
            let result = try context.execute(batchDeleteRequest)
            guard let deleteResult = result as? NSBatchDeleteResult,
                  let ids = deleteResult.result as? [NSManagedObjectID]
            else {
                return
            }

            let changes = [NSDeletedObjectsKey: ids]
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: changes,
                into: [self.contextProvider.mainQueueContext()]
            )
            return
        } catch {
            print("\n[DBRepository - \(DBEntity.self)]\n", "method: eraseAllData\n", "Error: \(error)\n\n")
        }
    }
}

extension StorageCore {

    private func saveIn(
        data: [DomainModel]
    ) {
        var existingObjects: [String: DBEntity] = [:]
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.associatedEntityName)

        let context = contextProvider.mainQueueContext()

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
        context.saveContext()
    }
}
