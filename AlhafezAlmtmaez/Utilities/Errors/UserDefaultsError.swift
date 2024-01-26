//
//  UserDefaultsError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

//extension ApplicationError {
//    enum UserDefaults: StringIdentifiable {
//        static func makeEncodingError(
//            message: String = .error.Serialization,
//            debugMessage: String
//        ) -> ApplicationError {
//            .init(
//                type: "\(Self.identifier) - EncodingError",
//                message: message
//            )
//        }
//    }
//}

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
