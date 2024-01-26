//
//  NoDataNetworkResponseModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 25/01/2024.
//

import Foundation

/*
 {
   status: Bool
   message: String
   data: T?
 }
 */
struct NoDataNetworkResponseModel: NetworkResponse {
    struct NoDataModel: Codable, Equatable { }

    var status: Bool
    var message: String
    var validation: [String : String] = [:]
    var data: NoDataModel? = nil

    enum CodingKeys: CodingKey {
        case status
        case message
    }
}
