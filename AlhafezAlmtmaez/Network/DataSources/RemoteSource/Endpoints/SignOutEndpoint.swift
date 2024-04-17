//
//  SignOutEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 17/04/2024.
//

import Foundation

struct SignOutEndpoint: GetNetworkEndpoint {
    typealias Response = NoDataNetworkResponseModel

    var config: Configuration = .init(
        url: .logout
    )

    init(token: String) {
        config.setAuthorizationHeader(with: token)
    }
}
