//
//  UserCredentialsModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 27/01/2024.
//

import Foundation

struct UserCredentialsModel: Codable {
    let access_token: String
    let user: UserProfileModel

    enum CodingKeys: CodingKey {
        case access_token
        case user
    }
}
