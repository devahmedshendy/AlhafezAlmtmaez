//
//  UserProfileModel.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

struct UserProfileModel: Codable {
    let first_name: String
    let second_name: String
    let middle_name: String
    let last_name: String
    let full_name: String
    let email: String?
    let phone_number: String
    let parent_phone_number: String
    let gender: Int

    enum CodingKeys: CodingKey {
        case first_name
        case second_name
        case middle_name
        case last_name
        case full_name
        case email
        case phone_number
        case parent_phone_number
        case gender
    }
}
