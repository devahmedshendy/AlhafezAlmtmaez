//
//  NetworkResponseMessage.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

//import Foundation
//
//struct NetworkResponseMessage: Decodable {
//
//    // MARK: - Properties
//
//    private var anyValue: AnyCodableMessage?
//
//    var asStringValue: String {
//        guard case let .string(value) = anyValue else { return "" }
//
//        return value
//    }
//
//    var asFieldsValue: [String: String] {
//        guard case let .fields(value) = anyValue else { return [:] }
//
//        return value.reduce([String : String]()) { partialResult, next in
//            var partialResult = partialResult
//            partialResult[next.key] = next.value.joined(separator: "\n")
//
//            return partialResult
//        }
//    }
//
//    // MARK: - LifeCycle
//
//    init() {}
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//
//        anyValue = try? container.decode(AnyCodableMessage.self)
//    }
//}
//
//enum AnyCodableMessage: Codable, Equatable {
//    typealias Err = AnyCodableMessageError
//
//    case string(String)
//    case fields([String:[String]])
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//
//        if let value = try? container.decode(String.self) {
//            self = .string(value)
//
//        } else if let value = try? container.decode([String : [String]].self) {
//            self = .fields(value)
//        } else {
//            throw Err.makeTypeMismatch()
//        }
//
//    }
//}
//
//extension NetworkResponseMessage: Equatable {
//    static func ==(lhs: NetworkResponseMessage, rhs: NetworkResponseMessage) -> Bool {
//        lhs.anyValue == rhs.anyValue
//    }
//}
