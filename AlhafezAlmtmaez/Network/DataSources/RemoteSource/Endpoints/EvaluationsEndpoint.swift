//
//  EvaluationsEndpoint.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 18/04/2024.
//

import Foundation

struct EvaluationsEndpoint: PostNetworkEndpoint {
    typealias Response = NetworkResponseModel<EvaluationsDataModel>

    var config: Configuration = .init(
        url: .evaluations
    )

    init(token: String, date: String) {
        config.setAuthorizationHeader(with: token)

        config.httpBody = [
            .httpBody.date: date
        ]
    }
}
