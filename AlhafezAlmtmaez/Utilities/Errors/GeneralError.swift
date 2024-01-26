//
//  GeneralError.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 01/12/2023.
//

import Foundation

//extension ApplicationError {
//    enum General: StringIdentifiable {
//        static func makeUnknown(_ debugMessage: String) ->  ApplicationError {
//            .init(
//                type: "\(Self.identifier) - Unknown",
//                message: .error.Unknown,
//                debugMessage: debugMessage
//            )
//        }
//    }
//}

enum GeneralError: ApplicationError {
    case Unknown(_ debugMessage: String)

    var details: ErrorDetails {
        switch self {
        case .Unknown(let debugMessage):
            return .init(
                type: "\(Self.identifier) - Unknown",
                message: .error.Unknown,
                debugMessage: debugMessage
            )
        }
    }


}
