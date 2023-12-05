//
//  ServerRemoteRepository.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

class ServerRemoteRepository {

    // MARK: - Properties

    private(set) lazy var server: NetworkServer = AlhafezAlmtmaezServerProxy()

    // MARK: - Logic

    func request<T: NetworkEndpoint> (endpoint: T) async throws -> T.DataResponse {
        try await server.request(
            requestConfig: T.RequestConfiguration.self,
            responseModel: T.DataResponse.self
        )
    }

    func upload<T: NetworkEndpoint>(to endpoint: T) async throws -> T.DataResponse {
        try await server.upload(
            requestConfig: T.RequestConfiguration.self,
            responseModel: T.DataResponse.self
        )
    }
}
