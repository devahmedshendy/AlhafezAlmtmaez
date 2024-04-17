//
//  InMemoryCacheStorage.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

final class InMemoryCacheStorage {

    static let shared: InMemoryCacheStorage = .init()

    // MARK: - Properties

    private lazy var lock: NSLock = .init()

    // MARK: - LifeCycle

    private init() { }

    @PublishedOnMainUnlessNil
    private(set) var currentUserToken: String? = nil

    @PublishedOnMainUnlessNil
    private(set) var currentUserProfile: UserProfileVM? = nil

    // MARK: - Token

    func getCurrentUserToken() -> String? {
        defer { lock.unlock() }
        lock.lock()

        return currentUserToken
    }

    func setCurrentUserToken(_ newValue: String?) {
        defer { lock.unlock() }
        lock.lock()

        currentUserToken = newValue
    }

    func unsetToken() {
        defer { lock.unlock() }
        lock.lock()

        currentUserToken = nil
    }

    // MARK: - User Profile

    func setCurrentUserProfile(_ newValue: UserProfileVM?) {
        defer { lock.unlock() }
        lock.lock()

        currentUserProfile = newValue
    }
}
