//
//  NetworkRequestConfigurationP.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

protocol NetworkRequestConfigurable {
    var url: String { get }
    var httpMethod: String { get }
    var httpHeaders: [String : String] { get  set }
    var data: [String : String] { get }
}

extension NetworkRequestConfigurable {
    mutating func setAuthorizationHeader(with token: String) {
        httpHeaders[.httpHeader.authorization] = token
    }
}

// MARK: - GET

struct GetRequestConfiguration: NetworkRequestConfigurable {
    let url: String
    let httpMethod: String = .httpMethod.GET
    var httpHeaders: [String : String] = .defaultHeaders
    var httpParams: [String : String] = [:]

    var data: [String : String] { httpParams }

    init(url: String) {
        self.url = url
    }
}

// MARK: - POST

struct PostRequestConfiguration: NetworkRequestConfigurable {
    let url: String
    let httpMethod: String = .httpMethod.POST
    var httpHeaders: [String : String] = .defaultHeaders
    var httpBody: [String : String] = [:]

    var data: [String : String] { httpBody }

}

// MARK: - Default Http Headers

extension Dictionary where Key == String, Value == String {
    static var defaultHeaders: [String : String] = [
        .httpHeader.accept: "application/json"
    ]
}
