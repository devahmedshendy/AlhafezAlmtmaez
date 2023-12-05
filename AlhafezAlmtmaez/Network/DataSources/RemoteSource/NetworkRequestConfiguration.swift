//
//  NetworkRequestConfiguration.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkRequestConfiguration {
    static var url: String { get }
    static var httpMethod: String { get }
    static var httpHeaders: [String : String] { get set }
    static var data: [String : String] { get }
}

// MARK: - GET

protocol GetRequestConfiguration: NetworkRequestConfiguration {
    static var httpParams: [String : String] { get }
}
extension GetRequestConfiguration {
    static var httpMethod: String { .httpMethod.GET }
    static var data: [String : String] { httpParams }
}

// MARK: - POST

protocol PostRequestConfiguration: NetworkRequestConfiguration {
    static var httpBody: [String : String] { get }
}
extension PostRequestConfiguration {
    static var httpMethod: String { .httpMethod.POST }
    static var data: [String : String] { httpBody }
}

// MARK: - Default Http Headers

extension Dictionary where Key == String, Value == String {
    static var `default`: [String : String] = [
        .httpHeader.accept: "application/json"
    ]
}
