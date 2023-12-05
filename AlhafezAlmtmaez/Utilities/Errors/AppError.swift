//
//  AppError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

protocol AppError: LocalizedError, CustomStringConvertible, StringIdentifiable {
    var metadata: ErrorMetadata { get }
}

extension AppError {
    var message: String { metadata.message }
    var debugMessage: String { metadata.debugMessage }
    var description: String { debugMessage }
}

// MARK: - Metadata

struct ErrorMetadata {

    // MARK: - Properties

    let message: String
    let debugMessage: String

    // MARK: - LifeCycle

    init(type: String, message: String, debugMessage: String) {
        self.message = message
        self.debugMessage = "\(type) - \(debugMessage)"
    }

    init(type: String, message: String) {
        self.message = message
        self.debugMessage = "\(type) - \(message)"
    }
}
