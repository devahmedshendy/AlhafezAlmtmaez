//
//  KeychainStorage.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

final class KeychainStorage: KeychainDataSource {

    typealias Err = KeychainError

    private enum K {
        static let SecClass: String = kSecClass as String
        static let SecValueData: String = kSecValueData as String
        static let SecAttrService: String = kSecAttrService as String
        static let SecAttrAccount: String = kSecAttrAccount as String
        static let SecReturnData: String = kSecReturnData as String
        static let SecMatchLimit: String = kSecMatchLimit as String
    }

    private enum Status {
        static let Success: Int32 = errSecSuccess
        static let ItemNotFound: Int32 = errSecItemNotFound
        static let DuplicateItem: Int32 = errSecDuplicateItem
    }

    // MARK: - Properties

    private lazy var jsonDecoder: JSONDecoder = .init()
    private lazy var jsonEncoder: JSONEncoder = .init()

    // MARK: - LifeCycle

    deinit {
        print(Self.self)
    }

    // MARK: - Logic

    // Get

    func string(forService service: String) throws -> String? {
        var query: [String : Any] = buildGenericPasswordQuery(forService: service)
        query[K.SecMatchLimit] = kSecMatchLimitOne
        query[K.SecReturnData] = true

        return try get(type: String.self, query: query)
    }

    func getValue<T>(
        ofType type: T.Type,
        forService service: String
    ) throws -> T? where T: Decodable {
        var query: [String : Any] = buildGenericPasswordQuery(forService: service)
        query[K.SecMatchLimit] = kSecMatchLimitOne
        query[K.SecReturnData] = true

        return try get(type: type.self, query: query)
    }

    private func get<T>(
        type: T.Type,
        query: [String : Any]
    ) throws -> T? where T: Decodable {
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == Status.Success else {
            if status == Status.ItemNotFound { return nil }

            throw Err.unknown(osstatus: status)
        }

        guard let result = result as? Data else { return nil }

        return try jsonDecoder.decode(T.self, from: result)
    }

    // Upset

    func upset<T>(
        _ value: T,
        forService service: String
    ) throws where T: Encodable {
        let data = try jsonEncoder.encode(value)
        let dataDict: [String : Any] = [K.SecValueData : data]

        var query: [String : Any] = [
            kSecAttrService as String: service,
            kSecAttrAccount as String: Self.account,
            kSecClass as String: kSecClassGenericPassword
        ]
        query.merge(dataDict, uniquingKeysWith: { _, new in new })

        let status = SecItemAdd(query as CFDictionary, nil)

        // Handle error status
        if status == Status.DuplicateItem {
            let query = buildGenericPasswordQuery(forService: service)

            SecItemUpdate(query as CFDictionary, dataDict as CFDictionary)

        } else if status != Status.Success {
            throw Err.unknown(osstatus: status)
        }
    }

    // Remove

    func removeData(forService service: String) throws {
        let query: [String : Any] = [
            kSecAttrService as String: service,
            kSecAttrAccount as String: Self.account,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)

        // Handle error status
        if status == errSecItemNotFound {
            // do nothing
        } else if status != errSecSuccess {
            throw Err.unknown(osstatus: status)
        }
    }

    // MARK: - Helpers

    private func buildGenericPasswordQuery(
        forService service: String
    ) -> [String : Any] {
        [
            kSecAttrService as String: service,
            kSecAttrAccount as String: Self.account,
            kSecClass as String: kSecClassGenericPassword
        ]
    }
}

extension KeychainStorage {
    func clear() throws {
        for key in StorageKey.allKeys {
            try self.removeData(forService: key)
        }
    }
}
