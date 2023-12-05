//
//  UserDefaultsError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

enum UserDefaultsError: AppError {
    case EncodingError(_ metadata: ErrorMetadata)

    var metadata: ErrorMetadata {
        switch self {
        case .EncodingError(let m): return m
        }
    }
}

extension UserDefaultsError {
    static func makeEncodingError(
        message: String = .error.serialization,
        debugMessage: String
    ) -> Self {
        .EncodingError(
            .init(
                type: "\(Self.identifier) - EncodingError",
                message: message
            )
        )
    }
}
