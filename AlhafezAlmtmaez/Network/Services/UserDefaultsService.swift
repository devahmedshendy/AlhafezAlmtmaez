//
//  UserDefaultsService.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

extension UserDefaults {

    typealias Err = UserDefaultsError

    func hasValue(forKey key: String) -> Bool {
        self.object(forKey: key) != nil
    }

    func getString(forKey key: String) -> String? {
        self.string(forKey: key)
    }

    func setString(_ value: String, forKey key: String) {
        self.setValue(value, forKey: key)
    }

    func getBoolean(forKey key: String) -> Bool {
        self.bool(forKey: key)
    }

    func setBoolean(_ value: Bool, forKey key: String) {
        self.setValue(value, forKey: key)
    }

    func removeString(forKey key: String) {
        self.removeObject(forKey: key)
    }

    func getObject<T: Decodable>(ofType type: T.Type, forKey key: String)  -> T? {
        guard
            let data = self.data(forKey: key)
        else { return nil }

        do {
            let object = try JSONDecoder().decode(type, from: data)
            return object

        } catch let error as NSError {
            errorLog(error.debugDescription)
            return nil
        }
    }

    func setObject<T: Encodable>(_ object: T, forKey key: String) throws {
        do {
            let data = try JSONEncoder().encode(object)
            self.setValue(data, forKey: key)
            self.synchronize()

        } catch let error as NSError {
            errorLog(error.debugDescription)

            throw Err.EncodingError(
                error.localizedDescription
            )
        }
    }

    func clear() throws {
        for key in StorageKey.allKeys {
            self.removeObject(forKey: key)
        }

        self.dictionaryRepresentation()
            .keys
            .forEach { key in
                self.removeObject(forKey: key)
            }
    }
}

final class UserDefaultsService: BaseService {

    static let shared: UserDefaultsService = .init()

    typealias Key = StorageKey

    // MARK: - Properties

    var isFirstTimeRun: Bool { getIsFirstTimeRun() }

    private lazy var repository: UserDefaults = .standard

    // MARK: - LifeCycle

    private override init() { }

    // MARK: - is_first_time_run

    func getIsFirstTimeRun() -> Bool {
        guard repository.hasValue(forKey: Key.is_first_time_run) else {
            return true
        }

        return repository.getBoolean(forKey: Key.is_first_time_run)
    }

    func setNoMoreFirstTimeRun() {
        repository.setBoolean(false, forKey: Key.is_first_time_run)
    }
}
