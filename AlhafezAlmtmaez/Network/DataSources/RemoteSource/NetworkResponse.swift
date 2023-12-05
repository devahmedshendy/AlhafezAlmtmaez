//
//  NetworkResponse.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

/*
 {
   status: Bool
   message: String
   data: T? // Optional
 }
 */

import Foundation

protocol NetworkResponse: Decodable {
    associatedtype DataModel: Codable

    var status: Bool { get }
    // TODO: Don't you think we should let the UI layer do handle it?
    var message: NetworkResponseMessage { get }
    var data: DataModel? { get }
}

extension NetworkResponse {
    var isSuccess: Bool { status == true }
    var isFailed: Bool { status == false }

    var toast: String { message.value }
}

struct NoDataModel: Codable, Equatable { }
struct NoDataResponse: NetworkResponse {
    typealias DataModel = NoDataModel

    var status: Bool
    var message: NetworkResponseMessage

    var data: DataModel? = nil
}
