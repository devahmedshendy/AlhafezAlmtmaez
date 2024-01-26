//
//  ServerRemoteRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

class ServerRemoteRepository {

    // MARK: - Properties

    private lazy var serverProxy: NetworkServer = AlhafezAlmtmaezServerProxy()

    // MARK: - Logic

    func request<T: NetworkEndpoint> (
        endpoint: T
    ) async throws -> T.Response where T.Response: NetworkResponse {
        try await serverProxy.request(endpoint)
    }
}
