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

    // MARK: - Server Implementations

    func request<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response {
        try await run {
            try await server.request(
                requestConfig: requestConfig,
                responseModel: responseModel
            )
        } as! Response
    }

    func upload<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response {
        try await run {
            try await server.upload(
                requestConfig: requestConfig,
                responseModel: responseModel
            )
        } as! Response
    }

    // MARK: - Helpers

    private func run(
        block: () async throws -> any NetworkResponse
    ) async throws -> any NetworkResponse {
        do {
            return try await block()

        } catch Err.UnauthorizedAccount(let payload) {
            session.toInactiveState()
            throw Err.makeUnauthorizedAccount(
              message: payload.message
            )

        } catch {
            print(error)
            throw error
        }
    }
}
