//
//  IRepository.swift
//  TodoList
//
//  Created by MacBook Pro on 22.04.2023.
//

protocol IRepository {

    /// Модель используемая в бизнес логике
    associatedtype DomainModel

    /// Сохраняет объекты в репозиторий
    /// - Parameters:
    ///   - objects: Сохраняемые объекты
    ///   - completion: Завершение сохранения
    func save(_ objects: [DomainModel], completion: @escaping (Result<Void, Error>) -> Void)

    /// Сохраняет объекты в репозиторий с возможностью очистки данных
    /// - Parameters:
    ///   - objects: Сохраняемые объекты
    ///   - clearBeforeSaving: Запрос данных, которые нужно очистить перед сохранением новых
    ///   - completion: Завершение сохранения
    func save(_ objects: [DomainModel], clearBeforeSaving: IRepositorySearchRequest, completion: @escaping (Result<Void, Error>) -> Void)

    /// Загрузка данных из репозитория
    /// - Parameters:
    ///   - request: Запрос загружаемых данных
    ///   - completion: Результат загрузки данных
    func present(by request: IRepositorySearchRequest, completion: @escaping (Result<[DomainModel], Error>) -> Void)

    /// Удаление данных из репозитория
    /// - Parameters:
    ///   - request: Запрос данных, которые нужно удалить
    ///   - completion: Завершение удаления
    func delete(by request: IRepositorySearchRequest, completion: @escaping (Result<Void, Error>) -> Void)

    /// Удаление всех данных из репозитория
    /// - Parameter completion: Завершение удаления всех данных
    func eraseAllData(completion: @escaping (Result<Void, Error>) -> Void)
}
