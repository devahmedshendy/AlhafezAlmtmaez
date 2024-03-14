//
//  UserDefaultsError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

enum UserDefaultsError: ApplicationError {
    case EncodingError(_ debugMessage: String)

    var details: ErrorDetails {
        switch self {
        case .EncodingError(let debugMessage):
            return .init(
                type: "\(Self.identifier) - EncodingError",
                message: message,
                debugMessage: debugMessage
            )
        }
    }
}
