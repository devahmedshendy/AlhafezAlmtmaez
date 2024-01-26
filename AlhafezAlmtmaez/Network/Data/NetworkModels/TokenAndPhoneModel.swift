//
//  TokenAndPhoneModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 10/12/2023.
//

import Foundation

struct TokenAndPhoneModel: Codable {
    let access_token: String
    let phone_text: String

    enum CodingKeys: CodingKey {
        case access_token
        case phone_text
    }
}
