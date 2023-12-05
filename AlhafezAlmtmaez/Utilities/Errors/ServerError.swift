//
//  ServerError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

enum ServerError: AppError {
    case StatusCode(_ metadata: ErrorMetadata)
    case ForbiddenRequest(_ metadata: ErrorMetadata)
    case UnauthorizedAccount(_ metadata: ErrorMetadata)
    case UnprocessableContentRequest(_ metadata: ErrorMetadata)
    case FalseResponseStatus(_ metadata: ErrorMetadata)
    case MissingResponseData(_ metadata: ErrorMetadata)
    case FailedResponseSerialization(_ metadata: ErrorMetadata)

    var metadata: ErrorMetadata {
        switch self {
        case .StatusCode(let m): return m
        case .ForbiddenRequest(let m): return m
        case .UnauthorizedAccount(let m): return m
        case .UnprocessableContentRequest(let m): return m
        case .FalseResponseStatus(let m): return m
        case .MissingResponseData(let m): return m
        case .FailedResponseSerialization(let m): return m
        }
    }
}

extension ServerError {
    static func makeStatusCode(
        message: String = .error.unknown,
        debugMessage: String
    ) -> Self {
        .StatusCode(
            .init(
                type: "\(Self.identifier) - StatusCode",
                message: message,
                debugMessage: debugMessage
            )
        )
    }
    static func makeUnauthorizedAccount(message: String) -> Self {
        .UnauthorizedAccount(
            .init(
                type: "\(Self.identifier) - UnauthorizedAccount",
                message: message
            )
        )
    }

    static func makeForbiddenRequest(message: String) -> Self {
        .ForbiddenRequest(
            .init(
                type: "\(Self.identifier) - ForbiddenRequest",
                message: message
            )
        )
    }

    static func makeUnprocessableContentRequest(message: String) -> Self {
        .UnprocessableContentRequest(
            .init(
                type: "\(Self.identifier) - UnprocessableContentRequest",
                message: message
            )
        )
    }

    static func makeFalseResponseStatus(message: String) -> Self {
        .FailedResponseSerialization(
            .init(
                type: "\(Self.identifier) - FailedResponseSerialization",
                message: message
            )
        )
    }

    static func makeMissingResponseData(
        message: String = .error.unexpectedResponseData
    ) -> Self {
        .MissingResponseData(
            .init(
                type: "\(Self.identifier) - MissingResponseData",
                message: message
            )
        )
    }

    static func makeFailedResponseSerialization(
        message: String = .error.serialization,
        debugMessage: String
    ) -> Self {
        .MissingResponseData(
            .init(
                type: "\(Self.identifier) - MissingResponseData",
                message: message,
                debugMessage: debugMessage
            )
        )
    }
}
