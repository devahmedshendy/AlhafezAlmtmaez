//
//  GeneralError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

enum GeneralError: AppError {
    case Unknown(_ metadata: ErrorMetadata)

    var metadata: ErrorMetadata {
        switch self {
        case .Unknown(let m): return m
        }
    }
}

extension GeneralError {
    static func makeUnknown(_ debugMessage: String) ->  Self {
        .Unknown(
            .init(
                type: "\(Self.identifier) - Unknown",
                message: .error.unknown,
                debugMessage: debugMessage
            )
        )
    }
}
