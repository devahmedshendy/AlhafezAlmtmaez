//
//  NetworkResponse.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 05/12/2023.
//

import Foundation

protocol NetworkResponse: Decodable {
    associatedtype DataModel: Codable

    var status: Bool { get }
    var message: String { get }
    var validation: [String : String] { get }
    var data: DataModel? { get }
}

extension NetworkResponse {
    var isSuccess: Bool { status == true }
    var isFailed: Bool { status == false }
}
