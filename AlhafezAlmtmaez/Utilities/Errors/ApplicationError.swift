//
//  ApplicationError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/01/2024.
//

import Foundation

//struct ApplicationError: LocalizedError, CustomStringConvertible {
//    let message: String
//    let validation: [String : String]
//    let debugMessage: String
//    var description: String { debugMessage }
//
//    init(
//        type: String,
//        message: String,
//        validation: [String : String] = [:]
//    ) {
//        self.init(
//            type: type,
//            message: message,
//            debugMessage: message,
//            validation: validation
//        )
//    }
//
//    init(
//        type: String,
//        message: String,
//        debugMessage: String,
//        validation: [String : String] = [:]
//    ) {
//        self.message = message
//        self.debugMessage = "\(type) - \(debugMessage)"
//        self.validation = validation
//    }
//}

protocol ApplicationError: LocalizedError,
                             StringIdentifiable,
                             CustomStringConvertible,
                             CustomDebugStringConvertible {
    var details: ErrorDetails { get }
}

extension ApplicationError {
    var message: String { details.message }
    var debugMessage: String { details.debugMessage }
    var validation: [String : String] { details.validation }

    var description: String { details.message }
    var debugDescription: String { details.debugMessage }
}
