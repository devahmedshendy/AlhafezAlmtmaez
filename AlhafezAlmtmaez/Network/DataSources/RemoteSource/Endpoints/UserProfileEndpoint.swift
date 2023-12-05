//
//  UserProfileEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

struct UserProfileEndpoint: NetworkEndpoint {
    typealias RequestConfiguration = Config
    typealias DataResponse = Response

    enum Config: GetRequestConfiguration {
        static let url: String = .userProfile
        static var httpHeaders: [String : String] = .default
        static var httpParams: [String : String] = [:]
    }

    struct Response: NetworkResponse {
        typealias DataModel = UserProfileModel

        var status: Bool
        var message: NetworkResponseMessage
        var data: DataModel?
    }

    init(token: String) {
        Config.httpHeaders[.httpHeader.authorization] = token
    }
}
