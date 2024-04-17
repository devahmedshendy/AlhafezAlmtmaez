//
//  UserLocalDataRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class UserLocalDataRepository {

    typealias Key = StorageKey

    // MARK: - Properties

    private lazy var cache: InMemoryCacheStorage = .shared
    private lazy var defaults: UserDefaults = .standard
    private lazy var keychain: KeychainStorage = .init()

    // MARK: - Token

    var cachedCurrentUserToken: String {
        cache.getCurrentUserToken() ?? ""
    }

    func getCurrentUserToken() -> String? {
        defaults.getString(forKey: Key.token)
    }

    func storeCurrentUserToken(_ token: String) {
        defaults.setString(token, forKey: Key.token)
    }
    
    func removeCurrentUserToken() {
        while defaults.getString(forKey: Key.token) != nil {
            defaults.removeString(forKey: Key.token)
        }
        cache.setCurrentUserToken(nil)
    }

    func cacheCurrentUserToken(_ token: String) {
        cache.setCurrentUserToken(token)
    }

    // MARK: - User Profile

    func cacheCurrentUserProfile(_ profile: UserProfileModel) {
        cache.setCurrentUserProfile(.init(from: profile))
    }

    func removeCurrentUserProfile() {
        cache.setCurrentUserProfile(nil)
    }
}
