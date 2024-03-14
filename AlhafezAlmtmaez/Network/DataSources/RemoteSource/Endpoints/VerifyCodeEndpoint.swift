//
//  VerifyCodeEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 27/01/2024.
//

import Foundation

struct VerifyCodeEndpoint: PostNetworkEndpoint {
    typealias Response = NetworkResponseModel<UserCredentialsModel>

    var config: Configuration = .init(
        url: .verifyCode
    )

    init(dto: VerifyCodeFormDto) {
        config.setAuthorizationHeader(with: dto.verifyToken)

        config.httpBody = [
            .httpBody.code: dto.code
        ]
    }
}
