//
//  KeychainError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

//extension ApplicationError {
//    enum Keychain: StringIdentifiable {
//        static func makeDuplicateItem(forKey key: String) -> ApplicationError {
//            .init(
//                type: "\(Self.identifier) - DuplicateItem",
//                message: .error.AppSettings,
//                debugMessage: "Provided key: '\(key)' is already existed!"
//            )
//        }
//
//        static func makeInvalidData() -> ApplicationError {
//            .init(
//                type: "\(Self.identifier) - InvalidData",
//                message: .error.AppSettings,
//                debugMessage: "The type of data found is invalid"
//            )
//        }
//
//        static func makeUnhandled(osstatus: OSStatus) -> ApplicationError {
//            .init(
//                type: "\(Self.identifier) - Unhandled",
//                message: .error.AppSettings,
//                debugMessage: "Failed with osstatus: \(osstatus)!"
//            )
//        }
//    }
//}

enum KeychainError: ApplicationError {
    case DuplicateItem(_ key: String)
    case InvalidData
    case Unhandled(_ osstatus: OSStatus)

    var details: ErrorDetails {
        switch self {
        case .DuplicateItem(let key):
            return .init(
                type: "\(Self.identifier) - DuplicateItem",
                message: .error.AppSettings,
                debugMessage: "Provided key: '\(key)' is already existed!"
            )

        case .InvalidData:
            return .init(
                type: "\(Self.identifier) - InvalidData",
                message: .error.AppSettings,
                debugMessage: "The type of data found is invalid"
            )

        case .Unhandled(let osstatus):
            return .init(
                type: "\(Self.identifier) - Unhandled",
                message: .error.AppSettings,
                debugMessage: "Failed with osstatus: \(osstatus)!"
            )
        }
    }
}
