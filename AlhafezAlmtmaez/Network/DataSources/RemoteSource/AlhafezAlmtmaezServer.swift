//
//  AlhafezAlmtmaezServer.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation
import Combine
import Alamofire

final class AlhafezAlmtmaezServer: NetworkServer {

    typealias Err = ServerError

    // MARK: - NetworkServer

    func request<T: NetworkEndpoint>(
        _ endpoint: T
    ) async throws -> T.Response where T.Response: NetworkResponse {
        let requestConfig = endpoint.config
        let responseModel = T.Response.self

        let afTask = AF.request(
            requestConfig.url,
            method: HTTPMethod(rawValue: requestConfig.httpMethod),
            parameters: requestConfig.data,
            encoding: URLEncoding.default,
            headers: HTTPHeaders(requestConfig.httpHeaders)
        )
        .serializingDecodable(responseModel)

        return try await process(
            afTask: afTask,
            for: requestConfig
        )
    }

    // MARK: - Helpers

    private func process<Response: NetworkResponse>(
        afTask: DataTask<Response>,
        for config: any NetworkRequestConfigurable
    ) async throws -> Response {
        let afResponse = await afTask.response
        let afResult = afResponse.result

        guard let statusCode = afResponse.response?.statusCode else {
            throw Err.StatusCode(
                "Invalid HTTP status code for url: \(config.url)"
            )
        }

        switch afResult {
        case .success(let response):
            return try process(
                response: response,
                withStatusCode: statusCode
            )

        case .failure(let error as NSError):
            throw Err.FailedResponseSerialization(
                error.debugDescription
            )
        }
    }

    private func process<Response: NetworkResponse>(
        response: Response,
        withStatusCode statusCode: Int
    ) throws -> Response {
        print(response)

        if statusCode == .statusCodes.Unauth­orized {
            throw Err.UnauthorizedAccount(
                response.message,
                response.validation
            )

        } else if statusCode == .statusCodes.Forbidden {
            throw Err.ForbiddenRequest(
                response.message,
                response.validation
            )

        } else if statusCode == .statusCodes.UnprocessableContent {
            throw Err.UnprocessableContentRequest(
                response.message,
                response.validation
            )
        }

        if response.status == false {
            throw Err.FalseResponseStatus(
                response.message,
                response.validation
            )
        }

        return response
    }
}
