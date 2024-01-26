//
//  Publisher+Extension.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation
import Combine

extension Publisher {
    func subscribeOnGlobalQueue(
        qos: DispatchQoS.QoSClass = .default
    ) -> AnyPublisher<Self.Output, Self.Failure> {
        self
            .subscribe(on: DispatchQueue.global(qos: qos))
            .eraseToAnyPublisher()
    }

    func receiveOnMainLoop() -> AnyPublisher<Self.Output, Self.Failure> {
        self
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Error {
    func mapOnMain<T>(
        _ transform: @escaping (Self.Output) -> T
    ) -> AnyPublisher<T, Error> {
        self
            .receiveOnMainLoop()
            .map(transform)
            .eraseToAnyPublisher()
    }

    func sinkOnMain(
        onSuccess: @escaping (_ data: Self.Output) -> Void,
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) -> AnyCancellable {
        self
            .receiveOnMainLoop()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error as ApplicationError) = completion {
                        onFailure(error)
                    } else if case let .failure(error as NSError) = completion {
                        onFailure(
                            GeneralError.Unknown(
                                error.debugDescription
                            )
                        )
                    }
                },
                receiveValue: onSuccess
            )
    }

    func sinkOnMain(
        onFailure: @escaping (_ error: ApplicationError) -> Void
    ) -> AnyCancellable {
        self.sinkOnMain(
            onSuccess: { _ in },
            onFailure: onFailure
        )
    }
}

extension Publisher where Self.Failure == Never {
    func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output?>,
        on root: Root
    ) -> AnyCancellable {
        sink { [weak root] value in
            root?[keyPath: keyPath] = value
        }
    }

    func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on root: Root
    ) -> AnyCancellable {
        sink { [weak root] value in
            root?[keyPath: keyPath] = value
        }
    }
}
