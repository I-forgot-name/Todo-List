//
//  StorageCoreMock.swift
//  Storage
//
//  Created by MacBook Pro on 10.05.2023.
//

final class StorageCoreMock<DomainModel, DBEntity>: IStorageCore {

    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (objects: [DomainModel], Void)?
    var invokedSaveParametersList = [(objects: [DomainModel], Void)]()

    func save(_ objects: [DomainModel]) {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (objects, ())
        invokedSaveParametersList.append((objects, ()))
    }

    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (request: IStorageSearchRequest, Void)?
    var invokedPresentParametersList = [(request: IStorageSearchRequest, Void)]()
    var stubbedPresentResult: Result<[DomainModel], Error>!

    func present(by request: IStorageSearchRequest) -> Result<[DomainModel], Error> {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (request, ())
        invokedPresentParametersList.append((request, ()))
        return stubbedPresentResult
    }

    var invokedDelete = false
    var invokedDeleteCount = 0
    var invokedDeleteParameters: (request: IStorageSearchRequest, Void)?
    var invokedDeleteParametersList = [(request: IStorageSearchRequest, Void)]()

    func delete(by request: IStorageSearchRequest) {
        invokedDelete = true
        invokedDeleteCount += 1
        invokedDeleteParameters = (request, ())
        invokedDeleteParametersList.append((request, ()))
    }

    var invokedEraseAllData = false
    var invokedEraseAllDataCount = 0

    func eraseAllData() {
        invokedEraseAllData = true
        invokedEraseAllDataCount += 1
    }
}
