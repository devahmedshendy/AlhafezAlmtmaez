//
//  ErrorDetails.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 26/01/2024.
//

import Foundation

struct ErrorDetails {
    let message: String
    let debugMessage: String
    let validation: [String : String]
    var description: String { debugMessage }

    init(
        type: String,
        message: String,
        debugMessage: String? = nil,
        validation: [String : String] = [:]
    ) {
        self.message = message
        self.debugMessage = "\(type) - \(debugMessage ?? message)"
        self.validation = validation
    }
}
