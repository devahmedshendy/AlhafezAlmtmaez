//
//  NetworkServer.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkServer {
    func request<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response

    func upload<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response
}
