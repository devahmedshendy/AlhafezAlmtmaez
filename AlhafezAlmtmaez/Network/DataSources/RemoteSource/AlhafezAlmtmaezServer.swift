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

    // MARK: - Logic

    func request<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response {
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
            for: Configuration.self
        )
    }

    func upload<
        Configuration: NetworkRequestConfiguration,
        Response: NetworkResponse
    >(
        requestConfig: Configuration.Type,
        responseModel: Response.Type
    ) async throws -> Response {
        let afTask = AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in Configuration.data {
                    if let url = URL(string: value) {
                        multipartFormData.append(url, withName: key)
                    }
                }
            },
            to: Configuration.url,
            headers: HTTPHeaders(requestConfig.httpHeaders)
        )
        .serializingDecodable(responseModel)

        return try await process(
            afTask: afTask,
            for: Configuration.self
        )
    }

    private func process<Response: NetworkResponse>(
        afTask: DataTask<Response>,
        for config: NetworkRequestConfiguration.Type
    ) async throws -> Response {
        let afResponse = await afTask.response
        let afResult = afResponse.result

        guard let statusCode = afResponse.response?.statusCode else {
            throw ServerError.makeStatusCode(
                debugMessage: "Invalid HTTP status code for url: \(config.url)"
            )
        }

        switch afResult {
        case .success(let response):
            print(response)

            if statusCode == .statusCodes.Unauth­orized {
                throw Err.makeUnauthorizedAccount(message: response.message.value)

            } else if statusCode == .statusCodes.Forbidden {
                throw Err.makeForbiddenRequest(message: response.message.value)

            } else if statusCode == .statusCodes.UnprocessableContent {
                throw Err.makeUnprocessableContentRequest(message: response.message.value)
            }

            if response.status == false {
                throw Err.makeFalseResponseStatus(
                    message: response.message.value
                )
            }

            return response

        case .failure(let error as NSError):
            throw Err.makeFailedResponseSerialization(
                debugMessage: error.debugDescription
            )
        }
    }
}
