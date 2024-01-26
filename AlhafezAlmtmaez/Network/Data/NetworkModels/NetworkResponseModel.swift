//
//  NetworkResponseModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/01/2024.
//

import Foundation

/*
 either this
 {
   status: Bool
   message: String
   data: T?
 }

 or this
 {
   status: Bool
   message: {
     String : [String]
   }
   data: T?
 }
 */

struct NetworkResponseModel<DataModel: Codable>: NetworkResponse {
    var status: Bool
    var message: String
    var validation: [String : String]
    var data: DataModel?

    enum CodingKeys: CodingKey {
        case status
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try container.decode(Bool.self, forKey: .status)

        if let message = try? container.decode(String.self, forKey: .message) {
            self.message = message
            self.validation = [:]
        } else if let validationObj = try? container.decode([String : [String]].self, forKey: .message) {
            self.message = .error.FormValidation
            self.validation = validationObj.values.count <= 1
            ? validationObj
                .mapValues {
                    $0
                        .compactMap { "• " + $0 }
                        .joined(separator: "\n")

                }
            : validationObj
                .mapValues {
                    $0
                        .compactMap { "• " + $0 }
                        .joined(separator: "\n")

                }

        // Just in case, so requests don't crash because of unexpceted message type
        } else {
            self.message = .error.Serialization
            self.validation = [:]
        }

        self.data = try container.decodeIfPresent(DataModel.self, forKey: .data)
    }
}
