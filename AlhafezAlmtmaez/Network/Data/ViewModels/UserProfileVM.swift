//
//  UserProfileVM.swift
//  AlhafezAlmtmaez
//
//  Created by Ahmed Shendy on 03/12/2023.
//

import Foundation

struct UserProfileVM {
    let firstName: String
    let secondName: String
    let middleName: String
    let lastName: String
    let fullName: String
    let email: String?
    let phoneNumber: String
    let parentPhoneNumber: String
    let gender: Int
}

extension UserProfileVM {
    init(from model: UserProfileModel) {
        firstName = model.first_name
        secondName = model.second_name
        middleName = model.middle_name
        lastName = model.last_name
        fullName = model.full_name
        email = model.email
        phoneNumber = model.phone_number
        parentPhoneNumber = model.parent_phone_number
        gender = model.gender
    }
}
