//
//  NetworkServer.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkServer {
    func request<T: NetworkEndpoint>(
        _ endpoint: T
    ) async throws -> T.Response where T.Response: NetworkResponse
}
