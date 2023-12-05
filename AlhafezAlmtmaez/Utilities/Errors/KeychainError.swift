//
//  KeychainError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

enum KeychainError: AppError {
    case DuplicateItem(_ metadata: ErrorMetadata)
    case InvalidData(_ metadata: ErrorMetadata)
    case Unhandled(_ metadata: ErrorMetadata)

    var metadata: ErrorMetadata {
        switch self {
        case .DuplicateItem(let m): return m
        case .InvalidData(let m): return m
        case .Unhandled(let m): return m
        }
    }
}

extension KeychainError {
    static func makeDuplicateItem(forKey key: String) -> Self {
        .DuplicateItem(
            .init(
                type: "\(Self.identifier) - DuplicateItem",
                message: .error.appSettings,
                debugMessage: "Provided key: '\(key)' is already existed!"
            )
        )
    }

    static func invalidData() -> Self {
        .InvalidData(
            .init(
                type: "\(Self.identifier) - InvalidData",
                message: .error.appSettings,
                debugMessage: "The type of data found is invalid"
            )
        )
    }

    static func unknown(osstatus: OSStatus) -> Self {
        .Unhandled(
            .init(
                type: "\(Self.identifier) - Unhandled",
                message: .error.appSettings,
                debugMessage: "Failed with osstatus: \(osstatus)!"
            )
        )
    }
}
