//
//  CachePublishedWrappers.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 27/01/2024.
//

import Foundation
import Combine

// MARK: - CachedCurrentUserProfileUnlessNil

@propertyWrapper
final class CachedCurrentUserProfileUnlessNil: CachedPublishedOptionalValue<UserProfileVM> {
    private let valueKeyPath: WrappedValueKeyPath = \.currentUserProfile
    private let publishedKeyPath: ProjectedValueKeyPath = \.$currentUserProfile

    var wrappedValue: CachedValue? {
        get {
            cache[keyPath: valueKeyPath]
        }
    }

    var projectedValue: AnyPublisher<CachedValue, Never> {
        get {
            cache[keyPath: publishedKeyPath]
                .compactMap { $0 }
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }

    init() {
        super.init(valueKeyPath, publishedKeyPath)
    }
}

// MARK: -

@propertyWrapper
final class CachedCurrentUserToken: CachedPublishedOptionalValue<String> {
    private let valueKeyPath: WrappedValueKeyPath = \.currentUserToken
    private let publishedKeyPath: ProjectedValueKeyPath = \.$currentUserToken

    var wrappedValue: CachedValue {
        get {
            cache[keyPath: valueKeyPath] ?? ""
        }
    }

    var projectedValue: AnyPublisher<CachedValue, Never> {
        get {
            cache[keyPath: publishedKeyPath]
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
    }

    init() {
        super.init(valueKeyPath, publishedKeyPath)
    }
}

// MARK: - CachedPublishedValue

protocol CachedValuePublishable: AnyObject {
    associatedtype CachedValue
}

// CachedPublishedValue

class CachedPublishedValue<Value>: CachedValuePublishable {
    typealias CachedValue = Value

    typealias WrappedValueKeyPath = KeyPath<InMemoryCacheStorage, CachedValue>
    typealias ProjectedValueKeyPath = KeyPath<InMemoryCacheStorage, AnyPublisher<CachedValue, Never>>

    // MARK: - Properties

    let cache: InMemoryCacheStorage = .shared

    private let valueKeyPath: WrappedValueKeyPath
    private let publishedKeyPath: ProjectedValueKeyPath

    // MARK: - LifeCycle

    init(
        _ valueKeyPath: WrappedValueKeyPath,
        _ publishedKeyPath: ProjectedValueKeyPath
    ) {
        self.valueKeyPath = valueKeyPath
        self.publishedKeyPath = publishedKeyPath
    }
}

// CachedPublishedOptionalValue

class CachedPublishedOptionalValue<Value>: CachedValuePublishable {
    typealias CachedValue = Value

    typealias WrappedValueKeyPath = KeyPath<InMemoryCacheStorage, CachedValue?>
    typealias ProjectedValueKeyPath = KeyPath<InMemoryCacheStorage, AnyPublisher<CachedValue, Never>>

    // MARK: - Properties

    let cache: InMemoryCacheStorage = .shared

    private let valueKeyPath: WrappedValueKeyPath
    private let publishedKeyPath: ProjectedValueKeyPath

    // MARK: - LifeCycle

    init(
        _ valueKeyPath: WrappedValueKeyPath,
        _ publishedKeyPath: ProjectedValueKeyPath
    ) {
        self.valueKeyPath = valueKeyPath
        self.publishedKeyPath = publishedKeyPath
    }
}
