//
//  IStorageCore.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

public protocol IStorageCore {

    /// Модель используемая в бизнес логике
    associatedtype DomainModel

    /// Сохраняет объекты в репозиторий
    /// - Parameters:
    ///   - objects: Сохраняемые объекты
    func save(_ objects: [DomainModel])

    /// Загрузка данных из репозитория
    /// - Parameter request: Запрос загружаемых данных
    /// - Returns: Результат загрузки данных
    func present(by request: IStorageSearchRequest) -> Result<[DomainModel], Error>

    /// Удаление данных из репозитория
    /// - Parameters: request: Запрос данных, которые нужно удалить
    func delete(by request: IStorageSearchRequest)

    /// Удаление всех данных из репозитория
    func eraseAllData()
}
