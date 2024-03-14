//
//  PublishedWrappers.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation
import Combine

// PublishedOnMain

@propertyWrapper
final class PublishedOnMain<Value> {

    @Published private var value: Value

    var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        $value
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}

// PublishedOnMainUnlessNil

@propertyWrapper
final class PublishedOnMainUnlessNil<Value> {

    // MARK: States

    @Published private var value: Value?

    // MARK: Properties

    var wrappedValue: Value? {
        get { value }
        set { value = newValue }
    }

    var projectedValue: AnyPublisher<Value, Never> {
        $value
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    // MARK: LifeCycle

    init(wrappedValue: Value?) {
        self.value = wrappedValue
    }

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}
