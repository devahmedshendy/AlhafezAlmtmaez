//
//  ServerError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

enum ServerError: ApplicationError {
    case StatusCode(
        _ debugMessage: String
    )
    case UnauthorizedAccount(
        _ message: String,
        _ validation: [String : String]
    )
    case ForbiddenRequest(
        _ message: String,
        _ validation: [String : String]
    )
    case UnprocessableContentRequest(
        _ message: String,
        _ validation: [String : String]
    )
    case FalseResponseStatus(
        _ message: String,
        _ validation: [String : String]
    )
    case MissingResponseData
    case FailedResponseSerialization(
        _ debugMessage: String
    )

    var details: ErrorDetails {
        switch self {
        case .StatusCode(let debugMessage):
            return.init(
                type: "\(Self.identifier) - StatusCode",
                message: .error.Unknown,
                debugMessage: debugMessage
            )

        case .UnauthorizedAccount(let message, let validation):
            return .init(
                type: "\(Self.identifier) - UnauthorizedAccount",
                message: message,
                debugMessage: message,
                validation: validation
            )

        case .ForbiddenRequest(let message, let validation):
            return .init(
                type: "\(Self.identifier) - ForbiddenRequest",
                message: message,
                debugMessage: message,
                validation: validation
            )

        case .UnprocessableContentRequest(let message, let validation):
            return .init(
                type: "\(Self.identifier) - UnprocessableContentRequest",
                message: message,
                debugMessage: message,
                validation: validation
            )

        case .FalseResponseStatus(let message, let validation):
            return .init(
                type: "\(Self.identifier) - FalseResponseStatus",
                message: message,
                debugMessage: message,
                validation: validation
            )

        case .MissingResponseData:
            let message: String = .error.MissingResponseData
            return .init(
                type: "\(Self.identifier) - MissingResponseData",
                message: message,
                debugMessage: message
            )


        case .FailedResponseSerialization(let debugMessage):
            return .init(
                type: "\(Self.identifier) - FailedResponseSerialization",
                message: .error .Serialization,
                debugMessage: debugMessage
            )

        }
    }
}
