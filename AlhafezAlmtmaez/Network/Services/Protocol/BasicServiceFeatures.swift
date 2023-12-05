//
//  BasicServiceFeatures.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation
import Combine

protocol BasicServiceFeatures {
    var subscriptions: [String : AnyCancellable] { get }
}

extension BasicServiceFeatures {
    func publisher<Output>(
        delay: TimeInterval = 0,
        _ asyncBlock: @escaping () async throws -> Output
    ) -> AnyPublisher<Output, Error> {
        Future<Output, Error> { promise in
            Task {
                do {
                    try await Task.sleep(
                        nanoseconds: UInt64(1_000_000_000 * delay)
                    )

                    let output = try await asyncBlock()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .subscribeOnGlobalQueue(qos: .userInitiated)
        .eraseToAnyPublisher()
    }
}
