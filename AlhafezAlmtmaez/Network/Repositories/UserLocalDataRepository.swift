//
//  UserLocalDataRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class UserLocalDataRepository {

    // MARK: - Properties

    private(set) lazy var cache: InMemoryCacheStorage = .shared
    private(set) lazy var defaults: UserDefaults = .standard
    private(set) lazy var keychain: KeychainStorage = .init()

    // MARK: - Token

    func getToken() -> String {
        cache.getCurrentUserToken() ?? ""
    }
}
