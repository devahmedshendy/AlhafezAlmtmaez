//
//  RequestVerificationCodeEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/12/2023.
//

import Foundation

struct RequestVerificationCodeEndpoint: PostNetworkEndpoint {
    typealias Response = NetworkResponseModel<TokenAndPhoneModel>

    var config: Configuration = .init(
        url: .requestVerificationCode
    )

    init(phoneNumber: String) {
        config.httpBody = [
            .httpBody.phone_number: phoneNumber
        ]
    }
}
