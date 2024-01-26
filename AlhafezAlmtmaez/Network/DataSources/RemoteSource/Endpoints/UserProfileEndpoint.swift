//
//  UserProfileEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 04/12/2023.
//

import Foundation

struct UserProfileEndpoint: GetNetworkEndpoint {
    typealias Response = NetworkResponseModel<UserProfileModel>

    var config: Configuration = .init(
        url: .userProfile
    )

    init(token: String) {
        config.httpHeaders[.httpHeader.authorization] = token
    }
}
