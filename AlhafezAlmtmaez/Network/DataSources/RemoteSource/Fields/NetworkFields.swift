//
//  NetworkResponseMessage.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

struct NetworkResponseMessage: Decodable {
    private var _value: [String] = []

    var value: String { _value.joined(separator: "\n") }

    init() {

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let singleMessage = try? container.decode(String.self) {
            _value = [singleMessage]

        } else if let messages = try? container.decode([String].self) {
            _value = messages

        } else if let messages = try? container.decode([String : [String]].self) {
            _value = Array(messages.values.reduce([], { $0 + $1 }))

        } else if container.decodeNil() {
            print("Response message is nil")

        } else {
            print("Response message is not empty and not string")
        }
    }
}

extension NetworkResponseMessage: Equatable {
    static func ==(lhs: NetworkResponseMessage, rhs: NetworkResponseMessage) -> Bool {
        lhs.value == rhs.value
    }
}
