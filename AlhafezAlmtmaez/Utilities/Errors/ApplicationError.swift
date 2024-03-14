//
//  ApplicationError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/01/2024.
//

import Foundation

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
