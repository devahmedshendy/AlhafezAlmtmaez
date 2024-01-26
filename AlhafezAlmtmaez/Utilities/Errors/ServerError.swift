//
//  ServerError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

//protocol AppError: LocalizedError, CustomStringConvertible, StringIdentifiable {
//    var message: String { get }
//    var validation: [String : String] { get }
//    var debugMessage: String { get }
//    var description: String { get }
//}
//
//extension AppError {
//    var description: String { debugMessage }
//}

//struct ServerError: AppError {
//    enum T: String {
//        case StatusCode
//        case UnauthorizedAccount
//        case ForbiddenRequest
//        case UnprocessableContentRequest
//        case FalseResponseStatus
//        case MissingResponseData
//        case FailedResponseSerialization
//    }
//    
//    let type: T
//    let message: String
//    let validation: [String : String]
//    var debugMessage: String
//
//    init(
//        type: T,
//        message: String,
//        validation: [String : String] = [:],
//        debugMessage: String
//    ) {
//        self.type = type
//        self.message = message
//        self.validation = validation
//        self.debugMessage = "\(Self.identifier) - \(type) - \(debugMessage)"
//    }
//
//    static func makeStatusCode(
//        message: String = .error.Unknown,
//        debugMessage: String
//    ) -> ServerError {
//        .init(
//            type: .StatusCode,
//            message: message,
//            debugMessage: debugMessage
//        )
//    }
//    static func makeUnauthorizedAccount(
//        message: String,
//        validation: [String : String]
//    ) -> ServerError {
//        .init(
//            type: .UnauthorizedAccount,
//            message: message,
//            validation: validation, 
//            debugMessage: message
//        )
//    }
//
//    static func makeForbiddenRequest(
//        message: String,
//        validation: [String : String]
//    ) -> ServerError {
//        .init(
//            type: .ForbiddenRequest,
//            message: message,
//            validation: validation,
//            debugMessage: message
//        )
//    }
//
//    static func makeUnprocessableContentRequest(
//        message: String,
//        validation: [String : String]
//    ) -> ServerError {
//        .init(
//            type: .UnprocessableContentRequest,
//            message: message,
//            validation: validation,
//            debugMessage: message
//        )
//    }
//
//    static func makeFalseResponseStatus(
//        message: String,
//        validation: [String : String]
//    ) -> ServerError {
//        .init(
//            type: .FalseResponseStatus,
//            message: message,
//            validation: validation,
//            debugMessage: message
//        )
//    }
//
//    static func makeMissingResponseData(
//        message: String = .error.UnexpectedResponseData
//    ) -> ServerError {
//        .init(
//            type: .MissingResponseData,
//            message: message,
//            debugMessage: message
//        )
//    }
//
//    static func makeFailedResponseSerialization(
//        message: String = .error.Serialization,
//        debugMessage: String
//    ) -> ServerError {
//        .init(
//            type: .FailedResponseSerialization,
//            message: message,
//            debugMessage: debugMessage
//        )
//    }
//}

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
