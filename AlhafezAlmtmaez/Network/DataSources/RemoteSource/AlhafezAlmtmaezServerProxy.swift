//
//  AlhafezAlmtmaezServerProxy.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

final class AlhafezAlmtmaezServerProxy: NetworkServer {

    typealias Err = ServerError

    // MARK: - Properties

    private lazy var server: NetworkServer = AlhafezAlmtmaezServer()

    private lazy var session: UserSession = .shared

    // MARK: - NetworkServer

    // NetworkResponse

    func request<T: NetworkEndpoint>(
        _ endpoint: T
    ) async throws -> T.Response where T.Response: NetworkResponse {
        try await run {
            try await server.request(endpoint)
        } as! T.Response
    }

    // MARK: - Helpers

    private func run(
        block: () async throws -> any NetworkResponse
    ) async throws -> any NetworkResponse {
        do {
            return try await block()

        } catch Err.UnauthorizedAccount(let message, let validation) {
            session.toInactiveState()
            throw Err.UnauthorizedAccount(
                message,
                validation
            )

        } catch {
            errorLog(error)
            throw error
        }
    }
}
